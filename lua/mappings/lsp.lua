local M = {}

function M.set(client)
  local m = vim.keymap.set

  -- Mappings.
  local opts = { noremap = true, silent = true }
  m('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  m('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  m('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  m('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  m('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  m('n', 'T', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  m('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  m('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  m('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  m('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  if client.server_capabilities.documentFormattingProvider then
    m("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  end
end

return M
