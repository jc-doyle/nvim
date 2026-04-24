require("conform").setup({
  formatters_by_ft = {
    -- You can customize some of the format options for the filetype (:help conform.format)
    -- Conform will run the first available formatter
    javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "biome", "prettier", stop_after_first = true },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})
