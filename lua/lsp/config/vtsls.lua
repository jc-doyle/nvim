local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"

local function get_svelte_ls_config()
  local svelte_ls_path = mason_packages .. "/svelte-language-server"

  return vim.fn.isdirectory(svelte_ls_path) == 1
      and {
        name = "typescript-svelte-plugin",
        location = svelte_ls_path,
        languages = { "svelte" },
        configNamespace = "typescript",
        enableForWorkspaceTypeScriptVersions = true,
      }
      or {}
end

return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  settings = {
    javascript = {
      preferences = {
        -- importModuleSpecifier = "non-relative",
      },
      inlayHints = {
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "all" },
        variableTypes = { enabled = true },
      },
    },
    typescript = {
      preferences = {
        -- importModuleSpecifier = "non-relative",
      },
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        -- Inlay hint truncation.
        maxInlayHintLength = 30,
        -- For completion performance.
        completion = {
          enableServerSideFuzzyMatch = true,
          entriesLimit = 50,
        },
      },
      tsserver = {
        globalPlugins = {
          get_svelte_ls_config(),
        },
      },
    },
  },
}
