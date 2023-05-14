local cmp = require 'cmp'
local mappings = require 'mappings.completion'

local LspItemKind = {
	Text = " Text",
	Method = "󰆧 Method",
	Function = "󰊕 Function",
	Constructor = " Constructor",
	Field = " Field",
	Variable = " Variable",
	Class = "󰠱 Class",
	Interface = " Interface",
	Module = " Module",
	Property = "󰜢 Property",
	Unit = " Unit",
	Value = "󰎠 Value",
	Enum = "󰙅 Enum",
	Keyword = "󰌋 Keyword",
	Snippet = " Snippet",
	Color = "󰏘 Color",
	File = "󰈙 File",
	Reference = " Reference",
	Folder = " Folder",
	EnumMember = "󰙅 EnumMember",
	Constant = " Constant",
	Struct = "󰙅 Struct",
	Event = " Event",
	Opertaor = "󰆕 Operator",
	TypeParameter = "󰅲 TypeParameter",
}

local function format_kind(entry, item)
	local source = entry.source.name
	item.kind = LspItemKind[item.kind]

	if source == 'buffer' then
		item.kind = " Buffer"
	elseif source == 'spell' then
		item.kind = " Spell"
	elseif source == 'ledger' then
		item.kind = " Account"
	elseif source == 'luasnip' then
		item.abbr = item.abbr
	elseif source == 'latex_symbols' then
		local result = {}
		for word in string.gmatch(item.abbr, "[^%s]+") do
			table.insert(result, word)
		end
		item.abbr = result[1]
		if result[2] ~= nil then
			item.kind = result[2] .. " Symbol"
		end
	elseif source == 'pandoc_references' then
		if not string.match(item.abbr, '(%w+):(%g+)') then
			item.kind = " Citation"
		end
	end

	return item
end

local function truncate(item)
	if string.len(item.abbr) > 24 then
		if string.sub(item.abbr, 23, 23) == "," then
			item.abbr = string.sub(item.abbr, 1, 23) .. "…  "
		else
			item.abbr = string.sub(item.abbr, 1, 22) .. "…  "
		end
	end

	return item
end

local function format(entry, item)
	item = truncate(item)
	item = format_kind(entry, item)
	return item
end

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end
	},
	enabled = function()
		-- disable completion in comments
		local context = require 'cmp.config.context'
		if vim.api.nvim_get_mode().mode == 'c' then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	window = {
		documentation = {
			border = {'', '', '', ' ', '', '', '', ' '},
			winhighlight = 'NormalFloat:CmpDocumentationNormal,FloatBorder:CmpDocumentationNormal',
			maxwidth = 40,
			maxheight = 15
		}
	},
	sources = {
		{name = "nvim_lsp"},
		{name = "nvim_lsp_signature_help"},
		{name = "buffer"},
		{name = "path"},
		{name = "latex_symbols"},
		{name = "pandoc_references"},
		-- {name = "luasnip"},
		{name = "ledger"},
	},
	formatting = {format = format},
	mapping = mappings,
	autocomplete = false,
	view = {entries = 'native'}
})
