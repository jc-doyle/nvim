require 'utils.color'
local au = require 'utils.general'.autocmd
local colorbuddy = require('colorbuddy')
local Color = colorbuddy.Color
local colors = colorbuddy.colors
local Group = colorbuddy.Group
local styles = colorbuddy.styles
local hl = Group.new

local none = styles.NONE
local bold = styles.bold
local italic = styles.italic
local underline = styles.underline
local strikethrough = styles.strikethrough


vim.g.colors_name = 'default'

-- ------ colors ------
local template = {
  base0 = "#2E3647",
  base1 = "#3A4458",
  base2 = "#5E6A83",
  base3 = "#A0AECB",
  base4 = "#D7E1F5",
  base5 = "#F4F8FF",
  base6 = "#9ADBFF",
  base7 = "#FF79C2",
  base8 = "#8FFFBC",
  base9 = "#E8FFA6",
  base10 = "#FF92AC",
  base11 = "#FDAFFF",
  base12 = "#94F2FF",
  base13 = "#B7E1FF",
  base14 = "#9CABDF",
  base15 = "#9CA6FF",
}

-- ------ colors ------

-- Assign Colors
for index, value in pairs(template) do
  Color.new(index, value)
end

-- HIGHLIGHTS
-- Base
hl('Bold', colors.none, colors.none, bold)
hl('Italic', colors.none, colors.none, italic)
hl('Underline', colors.none, colors.none, underline)
hl('Strikethrough', colors.none, colors.none, strikethrough)

-- UI
hl('Normal', colors.base4, colors.base0)
hl('LineNr', colors.base1, colors.none)
hl('Cursor', colors.none, colors.base2:dark())
hl('iCursor', colors.none, colors.base4)
hl('CursorLine', colors.none, colors.base0:new_child('1', { { "dark", 0.01 } }))
hl('CursorLineNr', colors.base3, colors.none)
hl('CursorColumn', colors.none, colors.none)
hl('Conceal', colors.base11, colors.none, italic)
hl('Error', colors.base11, colors.none)
hl('Pmenu', colors.base3, colors.base1:new_child('2', { { "light", 0.03 } }))
hl('PmenuSel', colors.base5, colors.base1:new_child('3', { { "light", 0.06 } }))
hl('PmenuSbar', colors.none, colors.base1:new_child('4', { { "dark", 0.03 } }))
hl('PmenuThumb', colors.none, colors.base1:new_child('5', { { "light", 0.05 } }))
hl('NormalFloat', colors.none, colors.base1:new_child('5', { { "dark", 0.03 } }))
hl("FloatBorder", colors.base2, colors.base1:new_child('6', { { "dark", 0.03 } }), bold)

-- StatusLine
hl('StError', colors.base7, colors.base0)
hl('StWarn', colors.base14, colors.base0)
hl('StHint', colors.base2, colors.base0)
hl('StInfo', colors.base1, colors.base0)

hl('StNormal', colors.base0, colors.base6)
hl('StInsert', colors.base0, colors.base10)
hl('StVisual', colors.base0, colors.base8)
hl('StReplace', colors.base0, colors.base12)
hl('StSelect', colors.base0, colors.base13)
hl('StCommand', colors.base0, colors.base11)

hl('StInactive', colors.base0, colors.base1)
hl('StLine', colors.base1, colors.base0, strikethrough)
hl("StatusLineNC", colors.base0, colors.base0)
hl("StatusLine", colors.none, colors.base0)

hl("MatchParen", colors.base7, colors.none, bold)
hl("NonText", colors.base2, colors.none)
hl("SpecialKey", colors.base2, colors.none)
hl("SpellBad", colors.none, colors.none, underline)
hl("SpellCap", colors.base13, colors.none)
hl("SpellLocal", colors.base4, colors.none)
hl("SpellRare", colors.none, colors.none)
hl("Visual", colors.none, colors.base1)
hl("VisualNOS", colors.base2, colors.none)
hl("healthError", colors.base11, colors.none)
hl("healthSuccess", colors.base14, colors.none)
hl("healthWarning", colors.base13, colors.none)
hl("TermCursorNC", colors.base2, colors.none)
hl("Folded", colors.base2, colors.none)
hl("FoldColumn", colors.base15, colors.none)
hl("SignColumn", colors.base2, colors.none)
hl("Directory", colors.base6, colors.none)
hl("EndOfBuffer", colors.base0, colors.none)
hl("MsgArea", colors.base2, colors.base0)
hl("ErrorMsg", colors.base10, colors.none, italic)
hl("WarningMsg", colors.base13, colors.none)
hl("MoreMsg", colors.base3, colors.none)
hl("Yank", colors.none, colors.base1:light())

hl("Question", colors.base3, colors.none)
hl("WildMenu", colors.base15, colors.none)
hl("Search", colors.none, colors.base1, bold)
hl("CurSearch", colors.none, colors.base1:light(), bold)
hl("IncSearch", colors.base0, colors.base11)
hl("VertSplit", colors.base1, colors.none)

-- Standard Language Groups
hl("Boolean", colors.base10, colors.none)
hl("Character", colors.base12, colors.none)
hl("Comment", colors.base2, colors.none, italic)
hl("Conditional", colors.base7, colors.none)
hl("Constant", colors.base10, colors.none)
hl("Define", colors.base13, colors.none)
hl("Delimiter", colors.base3, colors.none)
hl("Exception", colors.base7, colors.none)
hl("Float", colors.base10, colors.none)
hl("Function", colors.base11, colors.none)
hl("Identifier", colors.base6, colors.none)
hl("Include", colors.base10, colors.none)
hl("Keyword", colors.base15, colors.none)
hl("Label", colors.base15, colors.none)
hl("Number", colors.base6, colors.none)
hl("Operator", colors.base10, colors.none)
hl("PreProc", colors.base14, colors.none)
hl("Repeat", colors.base7, colors.none)
hl("Special", colors.base15, colors.none)
hl("SpecialChar", colors.base15, colors.none)
hl("Statement", colors.base3, colors.none)
hl("String", colors.base8, colors.none)
hl("Structure", colors.base12, colors.none)
hl("Tag", colors.base10, colors.none)
hl("Title", colors.base6, colors.none, bold)
hl("Todo", colors.base11, colors.none)
hl("Type", colors.base6, colors.none)
hl("Typedef", colors.base13, colors.none)

--Treesitter
hl("@attribute", colors.base13, colors.none)
hl("@attribute.builtin", colors.base14, colors.none, italic)
hl("@boolean", colors.base10, colors.none)
hl("@character", colors.base12, colors.none)
hl("@comment", colors.base2, colors.none, italic)
hl("@conditional", colors.base7, colors.none)
hl("@constant", colors.base10, colors.none)
hl("@const.builtin", colors.base10, colors.none)
hl("@constructor", colors.base14, colors.none)
hl("@error", colors.none, colors.none, none)
hl("@exception", colors.base10, colors.none, italic)
hl("@define", colors.base13, colors.none)
hl("@delimiter", colors.base3, colors.none)
hl("@exception", colors.base7, colors.none)
hl("@field", colors.base13, colors.none)
hl("@float", colors.base10, colors.none)
hl("@function", colors.base11, colors.none)
hl("@function.method.call", colors.base6, colors.none)
hl("@funcBuiltin", colors.base11, colors.none)
hl("@identifier", colors.base6, colors.none)
hl("@include", colors.base10, colors.none)
hl("@keyword", colors.base15, colors.none, italic)
hl("@keyword.function", colors.base15, colors.none, italic)
hl("@keyword.operator", colors.base15, colors.none)
hl("@keyword.return", colors.base15, colors.none)
hl("@keyword.import", colors.base10, colors.none)
hl("@keyword.conditional", colors.base7, colors.none)
hl("@label", colors.base15, colors.none)
hl("@method", colors.base6, colors.none)
hl("@namespace", colors.base13, colors.none)
hl("@number", colors.base9, colors.none)
hl("@operator", colors.base14, colors.none)
hl("@parameter", colors.base13, colors.none)
hl("@property", colors.base6, colors.none)
hl("@punctuation.delimiter", colors.base3:dark(0.15), colors.none)
hl("@punctutation.bracket", colors.base4, colors.none)
hl("@punctutation.special", colors.base8, colors.none)
hl("@repeat", colors.base7, colors.none)
hl("@string", colors.base8, colors.none)
hl("@stringRegex", colors.base11, colors.none)
hl("@stringEscape", colors.base9, colors.none)
hl("@stringSpecial", colors.base14, colors.none)
hl("@symbol", colors.base12, colors.none)
hl("@tag", colors.base10, colors.none)
hl("@tag.attribute", colors.base13, colors.none, italic)
hl("@tag.delimiter", colors.base3, colors.none)

-- Text related
hl("@text", colors.base5, colors.none)
hl("@text.title.1", colors.base13, colors.none)
hl("@text.title.2", colors.base6, colors.none)
hl("@text.title.3", colors.base15, colors.none, italic)
hl("@text.title.4", colors.base3, colors.none, italic)

hl("@text.title.1.marker", colors.base1, colors.none)
hl("@text.title.2.marker", colors.base1, colors.none)
hl("@text.title.3.marker", colors.base1, colors.none)
hl("@text.title.4.marker", colors.base1, colors.none)

hl("@text.reference", colors.base13, colors.none)
hl("@text.literal", colors.base14, colors.none)


hl("@title", colors.base6, colors.none, bold)
hl("@type", colors.base14, colors.none)
hl("@type.builtin", colors.base3, colors.none)
hl("@variable", colors.base5, colors.none)
hl("@variable.member", colors.base13, colors.none)
hl("@variable.builtin", colors.base4, colors.none)
hl("@warning", colors.base2, colors.none)

-- Currently Disabled
hl("@definitionUsage", colors.none, colors.none, underline)
hl("@definition", colors.none, colors.base1:light(0.05), underline)

-- Quickfix
hl("qfFileName", colors.base6, colors.none)
hl("qfSeparatorLeft", colors.base3, colors.none)
hl("qfSeparatorRight", colors.base3, colors.none)
hl("qfLineNr", colors.base2, colors.none, italic)
hl("QuickFixLine", colors.none, colors.none, bold)
hl("BqfPreviewBorder", colors.base14, colors.none)
hl("BqfPreviewCursor", colors.none, colors.base2)

-- Plugins
hl('TabLineFill', colors.none, colors.base0)
hl('BufferOffset', colors.none, colors.base0)

hl('BufferCurrent', colors.base0, colors.base6)
hl('BufferCurrentSign', colors.base0, colors.base6)
hl('BufferCurrentIndex', colors.base0, colors.base6)
hl('BufferCurrentMod', colors.base0, colors.base6)

hl('BufferVisible', colors.base3, colors.base1)
hl('BufferVisibleSign', colors.base3, colors.base1)
hl('BufferVisibleIndex', colors.base3, colors.base1)
hl('BufferVisibleMod', colors.base3, colors.base1)

hl('BufferInactive', colors.base2, colors.base0)
hl('BufferInactiveSign', colors.base2, colors.base0)
hl('BufferInactiveIndex', colors.base2, colors.base0)
hl('BufferInactiveMod', colors.base2, colors.base0)

hl('BufferCurrentTarget', colors.base14, colors.base6, bold)
hl('BufferInactiveTarget', colors.base14, colors.base1, bold)
hl('BufferVisibleTarget', colors.base14, colors.base2, bold)
hl('BufferTabpageFill', colors.base0, colors.base0, bold)

hl("Scrollbar", colors.none, colors.base0:light(0.04))

hl("DapLine", colors.none, colors.base0:light(0.02))
hl("DapBreakpoint", colors.base7, colors.base0:light(0.02))
hl("DapStopped", colors.base6, colors.base0:light(0.02))
hl("DapLogPoint", colors.base14, colors.base0:light(0.02))

hl("NvimDapVirtualText", colors.base2, colors.base0, italic)

hl("NvimTreeNormal", colors.base4, colors.base0)
hl("NvimTreeRootFolder", colors.base7, colors.none, italic)
hl("NvimTreeIndentMarker", colors.base2, colors.none)
hl("NvimTreeFolderIcon", colors.base6, colors.none)
hl("NvimTreeFolderName", colors.base6, colors.none, bold)
hl("NvimTreeOpenedFolderName", colors.base6, colors.none, bold)
hl("NvimTreeOpenedFile", colors.base7, colors.none, italic)
hl("NvimTreeStatuslineNC", colors.none, colors.base0, italic)

hl("FloatermBorder", colors.base6, colors.base0)

hl("IndentBlanklineChar", colors.base0:light(0.02), colors.none)
hl("IndentBlanklineContextChar", colors.base2, colors.none, bold)

hl("GitSignsAdd", colors.base10, colors.none)
hl("GitSignsAddNr", colors.base13, colors.none)
hl("GitSignsAddLn", colors.base5, colors.base10)

hl("GitSignsChange", colors.base11, colors.none)
hl("GitSignsChangeNr", colors.base15, colors.none)
hl("GitSignsChangeLn", colors.base15, colors.base11)

hl("GitSignsDelete", colors.base7, colors.none)
hl("GitSignsDeleteNr", colors.base10, colors.none)
hl("GitSignsDeleteLn", colors.base5, colors.base7)

hl("GitSignsCurrentLineBlame", colors.base3, colors.none, italic)


hl("SpectreHeader", colors.base0, colors.none)
hl("SpectreFile", colors.base15, colors.none, bold)
hl("SpectreReplace", colors.base8, colors.base1)
hl("SpectreSearch", colors.base14, colors.base0, italic)

hl("CmpDocumentationNormal", colors.base4, colors.base0:light(0.05), italic)

hl("LspSignature", colors.base6, colors.none, bold)

-- Lsp
hl("DiagnosticError", colors.base10, colors.none, italic)
hl("DiagnosticWarn", colors.base14, colors.none, italic)
hl("DiagnosticInfo", colors.base2, colors.none, italic)
hl("DiagnosticHint", colors.base2, colors.none, italic)

hl("TroubleFile", colors.base6, colors.none, italic)
hl("TroubleNormal", colors.base5, colors.none)
hl("TroubleCount", colors.base11, colors.base0:light(0.02))


hl("FocusedSymbol", colors.base6, colors.none, bold)

hl("WhichKey", colors.base11, colors.none, bold)
hl("WhichKeySeperator", colors.base2, colors.none, none)
hl("WhichKeyGroup", colors.base6, colors.none, none)
hl("WhichKeyDesc", colors.base4, colors.none, none)

hl("TelescopeSelection", colors.base6, colors.base0:light(0.02), bold)
hl("TelescopeSelectionCarat", colors.base7, colors.none)
hl("TelescopeMultiSelection", colors.base11, colors.none, bold)
hl("TelescopeNormal", colors.base4, colors.none)

hl("TelescopeBorder", colors.base4, colors.none)
hl("TelescopePromptBorder", colors.base10, colors.none)
hl("TelescopeResultsBorder", colors.base6, colors.none)
hl("TelescopePreviewBorder", colors.base3, colors.none)

hl("TelescopeMatching", colors.base6, colors.none, bold)
hl("TelescopePromptPrefix", colors.base10, colors.none)

hl("StartifyHeader", colors.base6, colors.none)

-- Language Specific
-- Markdown

-- hl("markdownH1", colors.base11, colors.none, bold)
-- -- hl("markdownH2", colors.base6, colors.none, bold)
-- hl("markdownH3", colors.base6, colors.none, italic)
-- hl("markdownH4", colors.base14, colors.none, italic)
--
-- hl("markdownH1Delimiter", colors.base1, colors.none, italic)
-- hl("markdownH2Delimiter", colors.base1, colors.none, italic)
-- hl("markdownH3Delimiter", colors.base1, colors.none, italic)
-- hl("markdownH4Delimiter", colors.base1, colors.none, italic)
-- hl("markdownCodeDelimiter", colors.base2, colors.none, italic)
--
hl("markdownListMarker", colors.base8, colors.none, bold)
-- hl("markdownLinkText", colors.base7, colors.none, bold)

-- Ledger
hl("@number.ledger", colors.base10, colors.none)
hl("@text.literal.ledger", colors.base3, colors.none, italic)
hl("@payee", colors.base3, colors.none, italic)


-- Yaml
hl("yamlDocumentStart", colors.base2, colors.none)
hl("yamlFlowCollection", colors.base4, colors.none)
hl("yamlPlainScalar", colors.base5, colors.none)
hl("yamlBlockMappingKey", colors.base11, colors.none, italic)
hl("yamlKeyValueDelimiter", colors.base2, colors.none, italic)

-- R
hl("routnormal", colors.base4, colors.none)
hl("routerror", colors.base10, colors.none, italic)

-- Java Docs
hl("java1", colors.base11, colors.none, italic)

-- Highlight Yank
au(
  'TextYankPost',
  '* silent!',
  'lua vim.highlight.on_yank{ higroup="Yank", timeout=250 }'
)
