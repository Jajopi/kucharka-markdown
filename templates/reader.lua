-- Custom pandoc reader: parses every input file separately as Markdown and
-- joins the results. This way footnote labels ([^1], [^2], …) only need to be
-- unique within one chapter file, not across the whole book.
--
-- It also stores the date the file was last changed (DD.MM.YYYY) in the
-- attribute `updated` of every top-level heading of that file; kucharka.lua
-- prints it below the chapter title. The date is the date of the last git
-- commit touching the file; if the file has uncommitted changes (or git is not
-- available), the file's modification time is used instead.

local function run(cmd, args)
  local ok, out = pcall(pandoc.pipe, cmd, args, '')
  if ok then return (out:gsub('%s+$', '')) end
end

local function last_updated(file)
  if file == '' or file == '-' then return nil end
  local dirty = run('git', { 'status', '--porcelain', '--', file })
  if dirty == '' then
    local date = run('git', { 'log', '-1', '--format=%cd', '--date=format:%d.%m.%Y', '--', file })
    if date and date ~= '' then return date end
  end
  local date = run('date', { '-r', file, '+%d.%m.%Y' })
  if date and date ~= '' then return date end
end

function Reader(sources, opts)
  local blocks = pandoc.Blocks {}
  local meta = {}
  for _, src in ipairs(sources) do
    local doc = pandoc.read(src.text, 'markdown+ascii_identifiers', opts)
    local updated
    for _, b in ipairs(doc.blocks) do
      if b.t == 'Header' and b.level == 1 then
        updated = updated or last_updated(src.name) or false
        if updated then b.attributes.updated = updated end
      end
    end
    blocks:extend(doc.blocks)
    for k, v in pairs(doc.meta) do meta[k] = v end
  end
  return pandoc.Pandoc(blocks, meta)
end
