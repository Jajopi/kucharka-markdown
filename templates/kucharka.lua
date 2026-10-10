--[[
kucharka.lua – pandoc filter used by all outputs (PDF, HTML, chunked HTML).

* numbers chapters (1, 2, …) and appendices (A, B, …); appendices are the
  chapters after the `::: appendices :::` marker that the Makefile inserts
  before the letter-named files
* internal links:
    [text](#id) or [text](3.md#id)  – link to a heading
    [](#id)                         – link text = heading title
    [#](#id)                        – link text = chapter number / letter
  broken internal links produce a warning
* PDF only: external links get a footnote with the URL (unless the link
  text already is the URL)
* PDF: title page built from metadata; HTML: intro goes to the title block
* Czech: non-breaking space after one-letter prepositions (v, k, s, z, …)
]]

local stringify = pandoc.utils.stringify
local is_latex = FORMAT:match('latex') ~= nil
local is_html = FORMAT:match('html') ~= nil

local LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

local function warn(msg)
  io.stderr:write('[kucharka] WARNING: ' .. msg .. '\n')
end

local function latex(blocks_or_inlines)
  local doc
  if pandoc.utils.type(blocks_or_inlines) == 'Inlines' then
    doc = pandoc.Pandoc({ pandoc.Plain(blocks_or_inlines) })
  else
    doc = pandoc.Pandoc(blocks_or_inlines)
  end
  return pandoc.write(doc, 'latex'):gsub('%s+$', '')
end

-- Czech non-breaking spaces ------------------------------------------------

local ONE_LETTER = {
  v = true, k = true, s = true, z = true, o = true, u = true, a = true, i = true,
  V = true, K = true, S = true, Z = true, O = true, U = true, A = true, I = true,
}

local function nbsp(inlines)
  for i = 1, #inlines - 1 do
    local cur, nxt = inlines[i], inlines[i + 1]
    if cur.t == 'Str' and nxt.t == 'Space' then
      local last = cur.text:match('[%(„]?(%a)$')
      if last and ONE_LETTER[last] and (cur.text == last or cur.text:match('^[%(„]%a$')) then
        inlines[i + 1] = pandoc.Str('\u{a0}')
      end
    end
  end
  return inlines
end

-- characters missing in Latin Modern (PDF only) -----------------------------

-- Greek, arrows, math symbols, dingbats, emoji, … go to a fallback font
local function needs_fallback(cp)
  return (cp >= 0x0370 and cp <= 0x03FF) or (cp >= 0x2190 and cp ~= 0x2212)
end

local function fallback_str(s)
  local out, buf, changed = {}, {}, false
  local function flush()
    if #buf > 0 then out[#out + 1] = pandoc.Str(table.concat(buf)); buf = {} end
  end
  for _, cp in utf8.codes(s.text) do
    local ch = utf8.char(cp)
    if needs_fallback(cp) then
      flush()
      changed = true
      local cmd = ((cp >= 0x0370 and cp <= 0x03FF) or (cp >= 0x2190 and cp <= 0x22FF)) and '\\kfallbackm{' or '\\kfallback{'
      out[#out + 1] = pandoc.RawInline('latex', cmd .. ch .. '}')
    else
      buf[#buf + 1] = ch
    end
  end
  flush()
  if changed then return out end
end

-- links --------------------------------------------------------------------

local targets = {}

local function strip_scheme(s)
  return (s:gsub('^mailto:', ''):gsub('^https?://', ''):gsub('/$', ''))
end

local function internal_id(target)
  return target:match('^[%w%-_]*%.md#(.+)$') or target:match('^#(.+)$')
end

-- returns the (possibly modified) link and an optional URL footnote
local function handle_link(link, in_note, in_header)
  local id = internal_id(link.target)
  if id then
    link.target = '#' .. id
    local tg = targets[id]
    if not tg then
      warn('broken internal link: #' .. id .. ' (text: "' .. stringify(link.content) .. '")')
      return link
    end
    local text = stringify(link.content)
    if text == '' then
      link.content = tg.title:clone()
    elseif text == '#' then
      link.content = { pandoc.Str(tg.number) }
    end
    return link
  end
  if not is_latex or in_header then
    return link
  end
  local url = link.target
  if link.classes:includes('uri') or link.classes:includes('email')
      or strip_scheme(stringify(link.content)) == strip_scheme(url) then
    return link
  end
  local shown = url:gsub('^mailto:', '')
  local urllink = pandoc.Link({ pandoc.Str(shown) }, url, '', { class = 'uri' })
  if in_note then
    -- footnotes inside footnotes are not possible: append the URL instead
    return { link, pandoc.Space(), pandoc.Str('('), urllink, pandoc.Str(')') }
  end
  return { link, pandoc.Note({ pandoc.Plain({ urllink }) }) }
end

local function process_links(blocks)
  return blocks:walk({
    traverse = 'topdown',
    Note = function(note)
      return note:walk({ Link = function(l) return handle_link(l, true, false) end }), false
    end,
    Header = function(h)
      return h:walk({ Link = function(l) return handle_link(l, false, true) end }), false
    end,
    Link = function(l)
      return handle_link(l, false, false), false
    end,
  })
end

-- title page -----------------------------------------------------------------

local function meta_list(v)
  if v == nil then return {} end
  if pandoc.utils.type(v) == 'List' then return v end
  return { v }
end

local function qr_escape(s)
  return (s:gsub('([#%%&_{}~%^$\\])', '\\%1'))
end

local function latex_titlepage(meta)
  local parts = {}
  local function add(s) parts[#parts + 1] = s end
  add('\\begin{titlepage}')
  add('\\centering')
  add('{\\fontsize{30}{36}\\selectfont ' .. latex(meta.title) .. '\\par}')
  add('\\vspace{1.5cm}')
  if meta.intro then
    add('\\begin{minipage}{0.9\\textwidth}\\Large\\raggedright')
    add(latex(meta.intro))
    add('\\end{minipage}\\par')
  end
  add('\\vfill')
  local qrs = meta_list(meta.qrcodes)
  if #qrs > 0 then
    local cells = {}
    for _, q in ipairs(qrs) do
      local url = stringify(q.url)
      cells[#cells + 1] = '\\begin{minipage}[t]{0.45\\textwidth}\\centering'
        .. '\\href{' .. qr_escape(url) .. '}{\\color{black}\\qrcode[height=4.2cm]{' .. qr_escape(url) .. '}}\\par '
        .. '\\vspace{0.8em}'
        .. '{\\small\\url{' .. url .. '}}\\par '
        .. latex(q.caption or pandoc.Inlines {})
        .. '\\end{minipage}'
    end
    add(table.concat(cells, '\\hfill'))
    add('\\par')
  end
  add('\\vfill')
  if meta.author then
    add('{\\large ' .. latex(meta.author) .. '\\par}\\medskip')
  end
  local date = meta.date and latex(meta.date) or '\\today'
  local label = meta['updated-label'] and (latex(meta['updated-label']) .. ' ') or ''
  add('{\\large ' .. label .. date .. '\\par}')
  add('\\end{titlepage}')
  return pandoc.RawBlock('latex', table.concat(parts, '\n'))
end

-- repeated footnotes --------------------------------------------------------

-- A footnote referenced twice in one chapter ([^1] … [^1]) is printed once;
-- the second reference points to the first footnote. Two passes over the
-- notes in document order: 1. find repeats, 2. replace them.
local function dedup_notes(blocks)
  local per_chapter = FORMAT:match('chunkedhtml') ~= nil
  local function each_note(fn)
    local chapter, i = 0, 0
    return blocks:walk({
      traverse = 'topdown',
      Header = function(h) if h.level == 1 then chapter = chapter + 1 end end,
      Note = function(n)
        i = i + 1
        return fn(n, i, chapter), false
      end,
    })
  end
  local first_of, is_first, number = {}, {}, {}
  local seen, count, last_chapter = {}, 0, 0
  each_note(function(n, i, chapter)
    if per_chapter and chapter ~= last_chapter then count = 0 end
    last_chapter = chapter
    local key = chapter .. '\0' .. pandoc.write(pandoc.Pandoc(n.content), 'native')
    if seen[key] then
      first_of[i] = seen[key]
      is_first[seen[key]] = true
    else
      seen[key] = i
      count = count + 1
      number[i] = count   -- the number pandoc's HTML writer will give it
    end
  end)
  if next(first_of) == nil then return blocks end
  return each_note(function(n, i)
    local id = 'kfn' .. (first_of[i] or i)
    if first_of[i] then
      if is_latex then
        return pandoc.RawInline('latex', '\\footref{' .. id .. '}')
      end
      return pandoc.Link({ pandoc.Superscript({ pandoc.Str(tostring(number[first_of[i]])) }) },
        '#' .. id, '', { class = 'footnote-ref', role = 'doc-noteref' })
    elseif is_first[i] then
      local c = n.content:clone()
      if c[1] and c[1].content then
        if is_latex then
          c[1].content:insert(1, pandoc.RawInline('latex', '\\label{' .. id .. '}'))
        else
          c[1].content:insert(1, pandoc.Span({}, { id = id }))
        end
      end
      return pandoc.Note(c)
    end
  end)
end

-- PDF layout tweaks -----------------------------------------------------------

local function raw(s) return pandoc.RawBlock('latex', s) end

local function single_image(b)
  if b and (b.t == 'Para' or b.t == 'Plain') and #b.content == 1 and b.content[1].t == 'Image' then
    return b.content[1]
  end
end

-- height of a picture as a fraction of \linewidth (nil if unknown)
local function image_ratio(img)
  local ok, res = pcall(function()
    local data
    for _, dir in ipairs(PANDOC_STATE.resource_path) do
      local f = io.open(dir .. '/' .. img.src, 'rb')
      if f then data = f:read('a'); f:close(); break end
    end
    if not data then return nil end
    local size = pandoc.image.size(data)
    local width = tonumber((img.attributes.width or ''):match('^([%d.]+)%%$'))
    width = width and width / 100 or 1
    return width * size.height / size.width
  end)
  return ok and res or nil
end

-- vertical space (in LaTeX units) the block after a heading needs
local function space_needed(b)
  if b == nil then return nil end
  if b.t == 'Table' then
    local rows = #b.head.rows
    for _, body in ipairs(b.bodies) do rows = rows + #body.body end
    if rows <= 15 then return (rows + 2) .. '\\baselineskip' end
  end
  local img = single_image(b)
  if img then
    local r = image_ratio(img)
    if r then return string.format('%.3f\\linewidth+5\\baselineskip', r) end
  end
  return '3\\baselineskip'
end

function latex_tweaks(blocks)
  local out = pandoc.Blocks {}
  for i, b in ipairs(blocks) do
    if b.t == 'Header' and b.level >= 2 then
      -- a heading never stays alone at the bottom of a page: it moves to the
      -- next page together with (the beginning of) what follows
      local need = space_needed(blocks[i + 1]) or '3\\baselineskip'
      out:insert(raw('\\needspace{\\dimexpr ' .. need .. '+3\\baselineskip\\relax}'))
    elseif b.t == 'Table' then
      -- short tables are not split across pages
      local need = space_needed(b)
      if need:match('baselineskip$') and not (blocks[i - 1] and blocks[i - 1].t == 'Header') then
        out:insert(raw('\\needspace{' .. need .. '}'))
      end
    elseif b.t == 'DefinitionList' then
      -- description on its own line below the term
      for _, item in ipairs(b.content) do
        for _, def in ipairs(item[2]) do
          local first = def[1]
          if first and (first.t == 'Plain' or first.t == 'Para') and #first.content > 0 then
            first.content:insert(1, pandoc.RawInline('latex', '\\leavevmode\\par\\nopagebreak '))
          end
        end
      end
    end
    out:insert(b)
  end
  return out
end

-- main ---------------------------------------------------------------------

function Pandoc(doc)
  local meta = doc.meta
  local lang = meta.lang and stringify(meta.lang) or ''

  -- 1. number chapters, collect link targets, handle the appendix marker
  local blocks = pandoc.Blocks {}
  local chap, app, in_app, current = 0, 0, false, nil
  local seen = {}
  for _, b in ipairs(doc.blocks) do
    if b.t == 'Header' and b.identifier ~= '' then
      -- chapters are parsed separately, so make heading ids unique here
      local id, n = b.identifier, 0
      while seen[id] do n = n + 1; id = b.identifier .. '-' .. n end
      seen[id] = true
      b.identifier = id
    end
    if b.t == 'Div' and b.classes:includes('appendices') then
      in_app = true
      if is_latex then
        local name = meta['appendix-name'] and latex(meta['appendix-name']) or '\\appendixname'
        local title = meta['appendices-title'] and latex(meta['appendices-title'])
        blocks:insert(pandoc.RawBlock('latex', table.concat({
          '\\appendix',
          '\\renewcommand*{\\appendixname}{' .. name .. '}',
          '\\renewcommand*{\\chapterformat}{\\appendixname~\\thechapter\\ --\\enskip}',
          title and ('\\cleardoublepage\\phantomsection\\addcontentsline{toc}{part}{' .. title .. '}') or '',
        }, '\n')))
      end
    else
      if b.t == 'Header' then
        if b.level == 1 then
          if in_app then
            app = app + 1
            current = LETTERS:sub(app, app)
          else
            chap = chap + 1
            current = tostring(chap)
          end
        end
        if b.identifier ~= '' then
          targets[b.identifier] = { title = b.content:clone(), number = current or '' }
        end
        if is_html and b.level == 1 then
          b.content:insert(1, pandoc.Space())
          b.content:insert(1, pandoc.Span({ pandoc.Str(current .. '.') }, { class = 'header-section-number' }))
        end
      end
      blocks:insert(b)
    end
  end
  -- other link targets: explicit spans/divs with ids, e.g. [text]{#id}
  blocks:walk({
    Span = function(s) if s.identifier ~= '' then targets[s.identifier] = { title = s.content, number = '' } end end,
    Div = function(d) if d.identifier ~= '' then targets[d.identifier] = { title = {}, number = '' } end end,
  })

  -- 2. links and footnotes
  blocks = process_links(blocks)

  -- 3. Czech typography
  if lang:match('^cs') then
    blocks = blocks:walk({ Inlines = nbsp })
  end

  blocks = dedup_notes(blocks)
  if is_latex then
    blocks = latex_tweaks(blocks)
    blocks = blocks:walk({
      Str = fallback_str,
      -- centre pictures standing alone in a paragraph
      Para = function(p)
        if #p.content == 1 and p.content[1].t == 'Image' then
          return { pandoc.RawBlock('latex', '\\begin{center}'), p, pandoc.RawBlock('latex', '\\end{center}') }
        end
      end,
    })
  end

  -- 4. title page / title block
  if is_latex then
    meta['include-before'] = { latex_titlepage(meta) }
  elseif is_html then
    if meta.intro then meta.abstract = meta.intro end
    if not meta.date then meta.date = os.date('%Y-%m-%d') end
  end

  doc.blocks = blocks
  doc.meta = meta
  return doc
end
