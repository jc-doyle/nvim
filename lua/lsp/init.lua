local SERVERS = {
  "lua_ls",
  "basedpyright",
  "ruff",
  "just",
  "vtsls",
  "docker_compose_language_service",
  "dockerls",
  "jsonls",
  "svelte",
  "bashls",
  "clangd",
  "gopls",
  "rust_analyzer",
}


local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

local function load_server_config(server_name)
  local path = 'lsp.config.' .. server_name
  local ok, custom_config = pcall(require, path)
  if ok then
    return custom_config
  end
  return {}
end

local on_init = function(client)
  if client.server_capabilities then
    client.server_capabilities.semanticTokensProvider = false
  end
end

local on_attach = function(client, bufnr)
  require 'mappings.lsp'.set(client)

  -- require "lsp_signature".on_attach({
  --   bind = true,
  --   handler_opts = {
  --     border = "rounded"
  --   }
  -- }, bufnr)
end

local setup_servers = function(servers)
  for _, server_name in ipairs(servers) do
    local server_config = {
      capabilities = vim.deepcopy(capabilities),
      on_init = on_init,
      on_attach = on_attach,
    }

    local custom_config = load_server_config(server_name)
    server_config = vim.tbl_deep_extend("force", server_config, custom_config)

    require("lspconfig")[server_name].setup(server_config)
  end
end

-- Base setup
setup_servers(SERVERS)

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
  automatic_enable = false,
  ensure_installed = SERVERS
})
