local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

local config = {
  capabilities
}

return config
