-- Custom pandoc reader: parses every input file separately as Markdown and
-- joins the results. This way footnote labels ([^1], [^2], …) only need to be
-- unique within one chapter file, not across the whole book.

function Reader(sources, opts)
  local blocks = pandoc.Blocks {}
  local meta = {}
  for _, src in ipairs(sources) do
    local doc = pandoc.read(src.text, 'markdown+ascii_identifiers', opts)
    blocks:extend(doc.blocks)
    for k, v in pairs(doc.meta) do meta[k] = v end
  end
  return pandoc.Pandoc(blocks, meta)
end
