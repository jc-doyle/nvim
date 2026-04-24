local api = vim.api
local terminal = require('utils.terminal')
-- local ignored_buffers = { "bin/java", "[dap-repl]" }

local M = {}

local FLOATING_FILETYPES = {
  'NvimTree',
  'aerial'
}

local function is_floating(ft)
  for _, filetype in ipairs(FLOATING_FILETYPES) do
    if ft == filetype then
      return true
    end
  end
  return false
end

-- local function has_floating(windows)
--   for _, win in ipairs(windows) do
--     local buf = api.nvim_win_get_buf(win)
--     local ft = vim.bo[buf].filetype
--     if is_floating(ft) then
--       return true
--     end
--   end
--   return false
-- end

function M.get_valid_wins(wins)
  return vim.tbl_filter(function(win)
    local buf_num = api.nvim_win_get_buf(win)
    local buf_name = vim.fn.bufname(buf_num)
    return not (buf_name:find("scrollbar_") or buf_name:find('term://'))
  end, wins)
end

function M.close()
  local win = api.nvim_get_current_win()

  local buf = api.nvim_win_get_buf(win)
  local ft = vim.bo[buf].ft

  if is_floating(ft) then
    api.nvim_win_close(win, true)
    return
  end

  local wins = M.get_valid_wins(api.nvim_list_wins())
  -- if has_floating(wins) then
  -- end

  if terminal.is_open() then
    terminal.toggle()
  end

  if #wins == 0 then
    vim.cmd("q")
  else
    vim.cmd("bdelete!") -- Changed from wincmd c to more idiomatic quit
  end
end

-- New autocmd API usage
-- local close_group = vim.api.nvim_create_augroup("close", { clear = true })
--
-- vim.api.nvim_create_autocmd({"WinEnter", "BufWinEnter"}, {
--   pattern = "*",
--   callback = function()
--     require('utils.close').close_nvim()
--   end,
--   group = close_group
-- })
--
return M
