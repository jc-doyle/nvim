local utils = require 'statusline.utils'

local M = {}

function M.percent()
  local curr_line = vim.fn.line('.')
  local lines = vim.fn.line('$')

  local percent = vim.fn.round(curr_line / lines * 100)

  if percent < 10 then
    return "   󰘣   "
  elseif curr_line == lines then
    return "   󰘡   "
  else
    return string.format('  %2d%%%%  ', percent)
  end
end

function M.folder()
  return '  ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

function M.mode()
  local mode_icons = {
    ['n'] = '   󰋜   ',
    ['i'] = '   󰏫   ',
    ['s'] = '   󰫙   ',
    ['v'] = '   󰫙   ',
    ['r'] = '   󰛔   ',
    ['c'] = '   󰞷   ',
    ['t'] = '   󰞷   ',
  }

  return mode_icons[utils.mode_alias[vim.fn.mode()]]
end

function M.diag_errors()
  local err = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  if (#err > 0) and (vim.fn.mode() == 'n') then
    return ' 󰅗 ' .. #err
  else
    return ''
  end
end

function M.diag_warnings()
  local warn = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARNING })
  if (#warn > 0) and (vim.fn.mode() == 'n') then
    return '  ' .. #warn
  else
    return ''
  end
end

function M.diag_hints()
  local hint = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  if (#hint > 0) and (vim.fn.mode() == 'n') then
    return '  ' .. #hint
  else
    return ''
  end
end

function M.diag_info()
  local info = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  if #info > 0 then
    return '  ' .. #info
  else
    return ''
  end
end

function M.git_branch()
  local gsd = vim.b.gitsigns_status_dict

  if gsd and gsd.head and #gsd.head > 0 then
    return '󰘬 ' .. gsd.head .. ' '
  else
    return vim.bo.filetype .. ' '
  end
end

function M.lsp_active()
  if utils.lsp_active() then
    return '󰄶 '
  else
    return ''
  end
end

return M
