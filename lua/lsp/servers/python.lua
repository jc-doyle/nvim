local cmd = 'pylsp'

local config = {
  cmd = { cmd },
  filetypes = { "python" },
  settings = {
    pylsp = {
      plugins = {
        jedi_completion = {
          cache_for = { "pandas", "numpy", "panda3d" }
        }
      }
    }
  },
  single_file_support = true
}

return config
