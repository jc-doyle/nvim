local cmp = require 'cmp'
local luasnip = require 'luasnip'

local feedkey = function(key, mode)
	vim.fn.feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode)
end

vim.api.nvim_set_keymap(
	'i',
	'<CR>',
	'v:lua.MPairs.autopairs_cr()',
	{expr = true, noremap = true}
)

local M = {
	["<CR>"] = cmp.mapping(
		function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
				fallback()
			end
		end,
		{"i", "s"}
	),

	["<S-CR>"] = cmp.mapping(
		function(fallback)
			if luasnip.jumpable(-1) then
        luasnip.jump(-1)
			else
				fallback()
			end
		end,
		{"i", "s"}
	),

	["<Tab>"] = function()
		if luasnip.expand() then
      luasnip.expand()
		elseif vim.fn.pumvisible() == 1 then
			feedkey("<C-Space>", "i")
      -- cmp.mapping.complete()
		else
			feedkey("<Tab>", "n")
		end
	end,

	["<S-Tab>"] = function()
		if vim.fn.pumvisible() == 1 then
			feedkey("<C-Space>", "i")
		else
			feedkey("<Tab>", "n")
		end
	end,

	['<C-Space>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true}),

	["<C-j>"] = cmp.mapping(
		function(fallback)
			if vim.fn.pumvisible() == 1 then
				feedkey("<C-n>", "n")
			else
				fallback()
			end
		end,
		{"i", "s"}
	),

	["<C-k>"] = cmp.mapping(
		function(fallback)
			if vim.fn.pumvisible() == 1 then
				feedkey("<C-p>", "n")
			else
				fallback()
			end
		end,
		{"i", "s"}
	),
  ["C-S-j"] = cmp.mapping(cmp.mapping.scroll_docs(2), {"i"}),
  ["C-S-k"] = cmp.mapping(cmp.mapping.scroll_docs(2), {"i"}),
}

return M
