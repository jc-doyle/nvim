---@type vim.lsp.Config
local config = {
  filetypes = { 'astro', 'css', 'eruby', 'html', 'javascriptreact', 'less', 'sass', 'scss', 'typescriptreact', 'vue' },
  init_options = {
    includeLanguages = {
      javascriptreact = "html",
      typescriptreact = "html",
    },
  },
}

return config
