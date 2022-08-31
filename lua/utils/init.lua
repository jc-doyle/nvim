local M = {}

function M.open_snippets()
  local ft = vim.bo.filetype
  local path = vim.fn.stdpath('config') .. "/snippets/" .. ft .. ".snippets"

  if vim.fn.filereadable(path) == 1 then
    local cmd = ":e " .. path
    vim.cmd(cmd)
  else
    print("No such snippet file.")
  end
end

function M.refresh_snippets()
  require("luasnip").cleanup()
  require("luasnip.loaders.from_snipmate").lazy_load()
end

return M
