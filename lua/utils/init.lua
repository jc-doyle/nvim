local M = {}

function M.open_snippets()
  local ft = vim.bo.filetype
  local path = vim.fn.stdpath('config') .. "/snippets/snippets/" .. ft .. ".json"

  if vim.fn.filereadable(path) == 1 then
    local cmd = ":e " .. path
    vim.cmd(cmd)
  else
    print("No such snippet file.")
  end
end

function M.refresh_snippets()
  require("luasnip").cleanup()
  require("luasnip.loaders.from_vscode").load({ paths = {vim.fn.stdpath('config') .. "/snippets"}})
end

return M
