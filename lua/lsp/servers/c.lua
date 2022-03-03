local cmd = 'ccls'

local config = {
  cmd = { cmd },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  init_options = {
    cache = {
      directory = "/tmp/ccls-cache"
    },
  }
}

return config
