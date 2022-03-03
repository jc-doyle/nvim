-- local cmd = "pyright"
-- local cmd = { "pyright-langserver", "--stdio" }

local config = {
  cmd = {"jedi-language-server"},
  filetypes = {"python"},
  -- settings = {
  --   python = {
  --     analysis = {
  --       autoSearchPaths = true,
  --       diagnosticMode = "workspace",
  --       useLibraryCodeForTypes = true
  --     }
  --   }
  -- },
  -- single_file_support = true
}

return config
