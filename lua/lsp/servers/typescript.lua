local util = require('lspconfig').util

local config = {
  root_dir = util.root_pattern("package.json"),
  single_file_support = false,
}

return config
