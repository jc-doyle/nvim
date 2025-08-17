local function hex_to_rgb(hex)
    local r = tonumber(hex:sub(2, 3), 16)
    local g = tonumber(hex:sub(4, 5), 16)
    local b = tonumber(hex:sub(6, 7), 16)
    return { r = r, g = g, b = b }
end

local function rgb_to_hex(rgb)
    return string.format("#%02x%02x%02x", rgb.r, rgb.g, rgb.b)
end

local function light(hex, factor)
    local rgb = hex_to_rgb(hex)
    rgb.r = math.min(255, rgb.r + (255 - rgb.r) * factor)
    rgb.g = math.min(255, rgb.g + (255 - rgb.g) * factor)
    rgb.b = math.min(255, rgb.b + (255 - rgb.b) * factor)
    return rgb_to_hex(rgb)
end

local function dark(hex, factor)
    local rgb = hex_to_rgb(hex)
    rgb.r = math.max(0, rgb.r * (1 - factor))
    rgb.g = math.max(0, rgb.g * (1 - factor))
    rgb.b = math.max(0, rgb.b * (1 - factor))
    return rgb_to_hex(rgb)
end

-- ------ colors ------
local colors = {
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

local function hl(group, fg, bg, attr)
    local hl_opts = {}
    if fg then hl_opts.fg = fg end
    if bg then hl_opts.bg = bg end
    if attr then hl_opts[attr] = true end
    vim.api.nvim_set_hl(0, group, hl_opts)
end

-- Base
hl('Bold', nil, nil, 'bold')
hl('Italic', nil, nil, 'italic')
hl('Underline', nil, nil, 'underline')
hl('Strikethrough', nil, nil, 'strikethrough')

-- UI
hl('Normal', colors.base4, colors.base0)
hl('NormalFloat', nil, dark(colors.base1, 0.03))

hl('LineNr', colors.base1, nil)
hl('Cursor', nil, dark(colors.base2, 0.1))
hl('iCursor', nil, colors.base4)
hl('CursorLine', nil, dark(colors.base0, 0.02))
hl('CursorLineNr', colors.base3, nil)
hl('CursorColumn', nil, nil)

hl('Conceal', colors.base11, nil, 'italic')
hl('Error', colors.base11, nil)

hl('Pmenu', colors.base3, dark(colors.base1, 0.03))
hl('PmenuKind', colors.base2, dark(colors.base1, 0.03))
hl('PmenuSel', colors.base5, light(colors.base1, 0.05))

hl('PmenuKindSel', colors.base3, light(colors.base1, 0.05))
hl('PmenuSbar', nil, dark(colors.base1, 0.03))
hl('PmenuThumb', nil, light(colors.base1, 0.05))
hl("FloatBorder", colors.base2, dark(colors.base1, 0.03), 'bold')

-- StatusLine
hl('StError', colors.base7, colors.base0)
hl('StWarn', light(colors.base10, 0.4), colors.base0)
hl('StHint', colors.base14, colors.base0)
hl('StInfo', colors.base2, colors.base0)

hl('StText', colors.base2, colors.base0)
hl('StNormal', colors.base0, colors.base6)
hl('StInsert', colors.base0, colors.base10)
hl('StVisual', colors.base0, colors.base8)
hl('StReplace', colors.base0, colors.base12)
hl('StSelect', colors.base0, colors.base13)
hl('StCommand', colors.base0, colors.base11)

hl('StInactive', colors.base0, colors.base1)
hl('StLine', colors.base1, colors.base0, 'strikethrough')
hl("StatusLineNC", colors.base0, colors.base0)
hl("StatusLine", nil, colors.base0)

hl("MatchParen", colors.base7, nil, 'bold')
hl("NonText", colors.base2, nil)
hl("SpecialKey", colors.base2, nil)
hl("SpellBad", nil, nil, 'underline')
hl("SpellCap", colors.base13, nil)
hl("SpellLocal", colors.base4, nil)
hl("SpellRare", nil, nil)
hl("Visual", nil, colors.base1)
hl("VisualNOS", colors.base2, nil)
hl("healthError", colors.base11, nil)
hl("healthSuccess", colors.base14, nil)
hl("healthWarning", colors.base13, nil)
hl("TermCursorNC", colors.base2, nil)
hl("Folded", colors.base2, nil)
hl("FoldColumn", colors.base15, nil)
hl("SignColumn", colors.base2, nil)
hl("Directory", colors.base6, nil)
hl("EndOfBuffer", colors.base0, nil)
hl("MsgArea", colors.base2, colors.base0)
hl("ErrorMsg", colors.base10, nil, 'italic')
hl("WarningMsg", colors.base13, nil)
hl("MoreMsg", colors.base3, nil)
hl("Yank", nil, light(colors.base1, 0.1))

hl("Question", colors.base3, nil)
hl("WildMenu", colors.base15, nil)
hl("Search", nil, colors.base1, 'bold')
hl("CurSearch", nil, light(colors.base1, 0.1), 'bold')
hl("IncSearch", colors.base0, colors.base11)
hl("WinSeparator", colors.base1, nil)

-- Standard Language Groups
hl("Boolean", colors.base10, nil)
hl("Character", colors.base12, nil)
hl("Comment", colors.base2, nil, 'italic')
hl("Conditional", colors.base7, nil)
hl("Constant", colors.base10, nil)
hl("Define", colors.base13, nil)
hl("Delimiter", colors.base3, nil)
hl("Exception", colors.base7, nil)
hl("Float", colors.base10, nil)
hl("Function", colors.base11, nil)
hl("Identifier", colors.base6, nil)
hl("Include", colors.base10, nil)
hl("Keyword", colors.base15, nil)
hl("Label", colors.base15, nil)
hl("Number", colors.base6, nil)
hl("Operator", colors.base10, nil)
hl("PreProc", colors.base14, nil)
hl("Repeat", colors.base7, nil)
hl("Special", colors.base15, nil)
hl("SpecialChar", colors.base15, nil)
hl("Statement", colors.base3, nil)
hl("String", colors.base8, nil)
hl("Structure", colors.base12, nil)
hl("Tag", colors.base10, nil)
hl("Title", colors.base6, nil, 'bold')
hl("Todo", colors.base11, nil)
hl("Type", colors.base6, nil)
hl("Typedef", colors.base13, nil)

-- Diff
hl("DiffAdd", colors.base8, nil, 'bold')
hl("DiffTextAdd", colors.base8, nil)
hl("DiffText", colors.base8, nil, 'bold')
hl("DiffChange", colors.base14, nil)
hl("DiffDelete", dark(colors.base7, 0.5), nil)

-- Treesitter
hl("@attribute", colors.base13, nil)
hl("@attribute.builtin", colors.base14, nil, 'italic')
hl("@boolean", colors.base10, nil)
hl("@character", colors.base12, nil)
hl("@comment", colors.base2, nil, 'italic')
hl("@conditional", colors.base7, nil)
hl("@constant", colors.base10, nil)
hl("@const.builtin", colors.base10, nil)
hl("@constructor", colors.base14, nil)
hl("@error", nil, nil)
hl("@exception", colors.base10, nil, 'italic')
hl("@define", colors.base13, nil)
hl("@delimiter", colors.base3, nil)
hl("@exception", colors.base7, nil)
hl("@field", colors.base13, nil)
hl("@float", colors.base10, nil)
hl("@function", colors.base11, nil)
hl("@function.method.call", colors.base6, nil)
hl("@funcBuiltin", colors.base11, nil)
hl("@identifier", colors.base6, nil)
hl("@include", colors.base10, nil)
hl("@keyword", colors.base15, nil, 'italic')
hl("@keyword.function", colors.base15, nil, 'italic')
hl("@keyword.operator", colors.base15, nil)
hl("@keyword.return", colors.base15, nil)
hl("@keyword.import", colors.base10, nil)
hl("@keyword.conditional", colors.base7, nil)
hl("@label", colors.base15, nil)
hl("@method", colors.base6, nil)
hl("@namespace", colors.base13, nil)
hl("@number", colors.base9, nil)
hl("@operator", colors.base14, nil)
hl("@parameter", colors.base13, nil)
hl("@property", colors.base6, nil)
hl("@punctuation.delimiter", dark(colors.base3, 0.15), nil)
hl("@punctutation.bracket", colors.base4, nil)
hl("@punctutation.special", colors.base8, nil)
hl("@repeat", colors.base7, nil)
hl("@string", colors.base8, nil)
hl("@stringRegex", colors.base11, nil)
hl("@stringEscape", colors.base9, nil)
hl("@stringSpecial", colors.base14, nil)
hl("@symbol", colors.base12, nil)
hl("@tag", colors.base10, nil)
hl("@tag.attribute", colors.base13, nil, 'italic')
hl("@tag.delimiter", colors.base3, nil)

-- Text related
hl("@text", colors.base5, nil)
hl("@text.title.1", colors.base13, nil)
hl("@text.title.2", colors.base6, nil)
hl("@text.title.3", colors.base15, nil, 'italic')
hl("@text.title.4", colors.base3, nil, 'italic')

hl("@text.title.1.marker", colors.base1, nil)
hl("@text.title.2.marker", colors.base1, nil)
hl("@text.title.3.marker", colors.base1, nil)
hl("@text.title.4.marker", colors.base1, nil)

hl("@text.reference", colors.base13, nil)
hl("@text.literal", colors.base14, nil)

hl("@title", colors.base6, nil, 'bold')
hl("@type", colors.base14, nil)
hl("@type.builtin", colors.base3, nil)
hl("@variable", colors.base5, nil)
hl("@variable.member", colors.base13, nil)
hl("@variable.builtin", colors.base4, nil)
hl("@warning", colors.base2, nil)

-- Currently Disabled
hl("@definitionUsage", nil, nil, 'underline')
hl("@definition", nil, light(colors.base1, 0.05), 'underline')

-- Quickfix
hl("qfFileName", colors.base6, nil)
hl("qfSeparatorLeft", colors.base3, nil)
hl("qfSeparatorRight", colors.base3, nil)
hl("qfLineNr", colors.base2, nil, 'italic')
hl("QuickFixLine", nil, nil, 'bold')
hl("BqfPreviewBorder", colors.base14, nil)
hl("BqfPreviewCursor", nil, colors.base2)

-- Plugins
hl('TabLineFill', nil, colors.base0)
hl('BufferOffset', nil, colors.base0)

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

hl('BufferCurrentTarget', colors.base14, colors.base6, 'bold')
hl('BufferInactiveTarget', colors.base14, colors.base1, 'bold')
hl('BufferVisibleTarget', colors.base14, colors.base2, 'bold')
hl('BufferTabpageFill', colors.base0, colors.base0, 'bold')

hl("Scrollbar", nil, colors.base2)

hl("DapLine", nil, light(colors.base0, 0.02))
hl("DapBreakpoint", colors.base7, light(colors.base0, 0.02))
hl("DapStopped", colors.base6, light(colors.base0, 0.02))
hl("DapLogPoint", colors.base14, light(colors.base0, 0.02))

hl("NvimDapVirtualText", colors.base2, colors.base0, 'italic')

hl("NvimTreeNormal", colors.base4, colors.base0)
hl("NvimTreeRootFolder", colors.base7, nil, 'italic')
hl("NvimTreeIndentMarker", colors.base2, nil)
hl("NvimTreeFolderIcon", colors.base6, nil)
hl("NvimTreeFolderName", colors.base6, nil, 'bold')
hl("NvimTreeOpenedFolderName", colors.base6, nil, 'bold')
hl("NvimTreeOpenedFile", colors.base7, nil, 'italic')
hl("NvimTreeStatuslineNC", nil, colors.base0, 'italic')

hl("FloatermBorder", colors.base6, colors.base0)

hl("IndentBlanklineChar", light(colors.base0, 0.02), nil)
hl("IndentBlanklineContextChar", colors.base2, nil, 'bold')

hl("GitSignsAdd", colors.base10, nil)
hl("GitSignsAddNr", colors.base13, nil)
hl("GitSignsAddLn", colors.base5, colors.base10)

hl("GitSignsChange", colors.base11, nil)
hl("GitSignsChangeNr", colors.base15, nil)
hl("GitSignsChangeLn", colors.base15, colors.base11)

hl("GitSignsDelete", colors.base7, nil)
hl("GitSignsDeleteNr", colors.base10, nil)
hl("GitSignsDeleteLn", colors.base5, colors.base7)

hl("GitSignsCurrentLineBlame", colors.base3, nil, 'italic')

hl("SpectreHeader", colors.base0, nil)
hl("SpectreFile", colors.base15, nil, 'bold')
hl("SpectreReplace", colors.base8, colors.base1)
hl("SpectreSearch", colors.base14, colors.base0, 'italic')

hl("CmpDocumentationNormal", colors.base4, light(colors.base0, 0.05), 'italic')

hl("LspSignature", colors.base6, nil, 'bold')

-- Lsp
hl("DiagnosticError", colors.base7, nil, 'italic')
hl("DiagnosticWarn", light(colors.base10, 0.3), nil, 'italic')
hl("DiagnosticInfo", colors.base14, nil, 'italic')
hl("DiagnosticHint", colors.base2, nil, 'italic')

hl("TroubleFile", colors.base6, nil, 'italic')
hl("TroubleNormal", colors.base5, nil)
hl("TroubleNormalNC", colors.base5, nil)
hl("TroubleCount", colors.base11, light(colors.base0, 0.02))

hl("FocusedSymbol", colors.base6, nil, 'bold')

hl("WhichKey", colors.base11, nil, 'bold')
hl("WhichKeySeperator", colors.base2, nil)
hl("WhichKeyGroup", colors.base6, nil)
hl("WhichKeyDesc", colors.base4, nil)

hl("TelescopeSelection", colors.base6, light(colors.base0, 0.02), 'bold')
hl("TelescopeSelectionCarat", colors.base7, nil)
hl("TelescopeMultiSelection", colors.base11, nil, 'bold')
hl("TelescopeNormal", colors.base4, nil)

hl("TelescopeBorder", colors.base4, nil)
hl("TelescopePromptBorder", colors.base10, nil)
hl("TelescopeResultsBorder", colors.base6, nil)
hl("TelescopePreviewBorder", colors.base3, nil)

hl("TelescopeMatching", colors.base6, nil, 'bold')
hl("TelescopePromptPrefix", colors.base10, nil)

hl("StartifyHeader", colors.base6, nil)

-- Language Specific
-- Markdown
hl("markdownListMarker", colors.base8, nil, 'bold')

-- Ledger
hl("@number.ledger", colors.base10, nil)
hl("@text.literal.ledger", colors.base3, nil, 'italic')
hl("@payee", colors.base3, nil, 'italic')

-- Yaml
hl("yamlDocumentStart", colors.base2, nil)
hl("yamlFlowCollection", colors.base4, nil)
hl("yamlPlainScalar", colors.base5, nil)
hl("yamlBlockMappingKey", colors.base11, nil, 'italic')
hl("yamlKeyValueDelimiter", colors.base2, nil, 'italic')

-- R
hl("routnormal", colors.base4, nil)
hl("routerror", colors.base10, nil, 'italic')

-- Java Docs
hl("java1", colors.base11, nil, 'italic')
