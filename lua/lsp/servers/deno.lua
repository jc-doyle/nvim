local util = require('lspconfig').util

local config = {
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
}

return config
