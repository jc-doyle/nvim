local api = vim.api

local special_buffers = { "bin/java", "[dap-repl]" }

local M = {}

local function is_special(bufname)
  for _, buffer in ipairs(special_buffers) do
    if bufname:find(buffer) then
      return true
    end
  end
  return false
end

function M.remove_wins(wins)
  return vim.tbl_filter(function(win)
    local buf_num = api.nvim_win_get_buf(win)
    local buf_name = vim.fn.bufname(buf_num)
    return not (buf_name:find("scrollbar_") or buf_name:find('term://'))
  end, wins)
end

function M.close_nvim()
  local wins = M.remove_wins(api.nvim_list_wins())

  if #wins == 0 then
    vim.cmd('q!')
  elseif (#wins == 1 and vim.fn.bufname() == "") then
    vim.cmd('q')
  end
end

function M.close()
  local wins = M.remove_wins(api.nvim_list_wins())

  if #wins == 0 then
    vim.cmd("q")
  elseif #wins == 1 then
    vim.cmd("bd")
  elseif is_special(vim.fn.bufname()) then
    vim.cmd("bdelete!")
  else
    vim.cmd("quit")  -- Changed from wincmd c to more idiomatic quit
  end
end

-- New autocmd API usage
local close_group = vim.api.nvim_create_augroup("close", { clear = true })

vim.api.nvim_create_autocmd({"WinEnter", "BufWinEnter"}, {
  pattern = "*",
  callback = function()
    require('utils.close').close_nvim()
  end,
  group = close_group
})

return M
