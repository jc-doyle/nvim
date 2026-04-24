require("aerial").setup({
  autojump = true,
  close_on_select = true,
  layout = {
    min_width = { 44, 0.24 },
    max_width = { 44, 0.24 },
  },
  backends = {
    ['_']           = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
    python          = { "treesitter" },
    rust            = { "lsp" },
    typescriptreact = { "treesitter" },
  }

  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  -- on_attach = function(bufnr)
  --   -- Jump forwards/backwards with '{' and '}'
  --   vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
  --   vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  -- end,
})
-- You probably also want to set a keymap to toggle aerial
-- vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
