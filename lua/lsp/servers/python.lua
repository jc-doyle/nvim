local cmd = 'pylsp'

local config = {
  cmd = {cmd},
  filetypes = { "python "},
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      }
    }
  },
  single_file_support = true
}

return config
