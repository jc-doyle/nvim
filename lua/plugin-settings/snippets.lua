-- require("luasnip.loaders.from_vscode").load({ paths = {vim.fn.stdpath('config') .. "/snippets"}})
require("luasnip.loaders.from_snipmate").lazy_load()

local types = require("luasnip.util.types")

require 'luasnip'.config.setup({
	ext_opts = {
		[types.choiceNode] = {active = {virt_text = {{"●", "StInfo"}}}},
		[types.insertNode] = {active = {virt_text = {{"●", "StInfo"}}}},
	},
  region_check_events = 'CursorMoved'
})
