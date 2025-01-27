local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

-- Helper function to merge tables
local function merge_tables(...)
  local result = {}
  for _, t in ipairs({ ... }) do
    for k, v in pairs(t) do
      result[k] = v
    end
  end
  return result
end

-- Load custom server configuration if it exists
local function load_server_config(server_name)
  local ok, custom_config = pcall(require, "config." .. server_name)
  if ok then
    return custom_config
  end
  return {}
end

-- Disable semantic tokens
local on_init = function(client)
  if client.server_capabilities then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local on_attach = function(client, bufnr)
  require 'mappings.lsp'.set(client, bufnr)
end

local function setup(server_name)
  -- Base configuration with capabilities
  local base_config = {
    capabilities = vim.deepcopy(capabilities),
    on_init = on_init,
    on_attach = on_attach
  }

  -- Load custom configuration for the server
  local custom_config = load_server_config(server_name)

  -- Merge configurations, with custom config taking precedence
  local server_opts = merge_tables(base_config, custom_config)

  -- print("Setting up " .. server_name .. " with config:")
  -- vim.print(server_opts)

  require("lspconfig")[server_name].setup(server_opts)
end

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "lua_ls",
    "pyright",
    "vtsls",
    -- "denols",
    "svelte",
    "bashls",
    "gopls",
    "rust_analyzer",
  }
})

-- Setup handlers
require("mason-lspconfig").setup_handlers({ setup })

-- Load UI and diagnostics configurations
require('lsp.ui')
require('lsp.diagnostics')
