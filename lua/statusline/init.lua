-- A groovy status line
local s = require 'statusline.components'
local utils = require 'statusline.utils'

local api = vim.api
local M = {}

-- Buffers that should have a blank statusline
local none = {
  buftypes = { 'terminal', 'quickfix' },
  filetypes = { 'Outline', 'NvimTree', 'trouble' },
  bufnames = { "Object_Browser" }
}

local function component(hlname, source)
  if source then
    return '%#' .. hlname .. '#' .. source
  end
  return '%#' .. hlname .. '#'
end

local function generate(context)
  local active = { left = {}, center = {}, right = {} }
  local inactive = { left = {}, center = {}, right = {} }

  -- Always include mode in active state
  active.left = {
    component(utils.mode_hl(), s.mode()),
    component('Normal'),
    component('StText', s.folder())
  }

  active.center = {
    component('StError', s.diag_errors()),
    component('StWarn', s.diag_warnings()),
    component('StHint', s.diag_hints()),
    component('StInfo', s.diag_info())
  }

  active.right = {
    component('StText', s.git_branch()),
    component('StText', s.lsp_active()),
    component(utils.mode_hl(), s.percent())
  }

  inactive.left = { component('StInactive', s.mode()), component('StLine') }
  inactive.center = { component('StLine') }
  inactive.right = { component('StLine'), component('StInactive', s.percent()) }

  local statusline = context.inactive and inactive or active

  if context.width < 40 then
    return string.format(
      "%s%%=%s",
      statusline.left[1] or '',
      statusline.right[#statusline.right] or ''
    )
  elseif context.width < 80 and not context.inactive then
    return string.format(
      "%s%%=%s",
      table.concat(statusline.left),
      table.concat(statusline.right)
    )
  else
    return string.format(
      "%s%%=%s%%=%s",
      table.concat(statusline.left),
      table.concat(statusline.center),
      table.concat(statusline.right)
    )
  end
end

local function is_forced_none(context)
  return vim.tbl_contains(none.buftypes, context.buftype)
      or vim.tbl_contains(none.filetypes, context.filetype)
      or vim.tbl_contains(none.bufnames, context.bufname)
end

function M.print()
  local curwin = vim.g.statusline_winid or 0
  local curbuf = api.nvim_win_get_buf(curwin)

  local context = {
    bufnum = curbuf,
    winid = curwin,
    bufname = vim.fn.bufname(curbuf),
    readonly = vim.bo[curbuf].readonly,
    filetype = vim.bo[curbuf].ft,
    buftype = vim.bo[curbuf].bt,
    fileformat = vim.bo[curbuf].fileformat,
    shiftwidth = vim.bo[curbuf].shiftwidth,
    width = api.nvim_win_get_width(curwin),
    inactive = api.nvim_get_current_win() ~= curwin
  }

  if is_forced_none(context) then
    return '%#StatusLineNC#'
  else
    return generate(context)
  end
end

-- Set up initial statusline
vim.o.statusline = '%!v:lua.require\'statusline\'.print()'

-- Create autogroup for statusline events
local statusline_group = api.nvim_create_augroup('statusline', { clear = true })

-- Update statusline on mode changes and window focus
api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'ModeChanged' }, {
  group = statusline_group,
  callback = function()
    if vim.fn.pumvisible() == 0 then
      vim.wo.statusline = '%!v:lua.require\'statusline\'.print()'
    end
  end,
})

-- Handle inactive windows
api.nvim_create_autocmd('WinLeave', {
  group = statusline_group,
  callback = function()
    local win = api.nvim_get_current_win()
    vim.wo[win].statusline = '%!v:lua.require\'statusline\'.print()'
  end,
})

-- Ensure terminal windows get proper statusline
api.nvim_create_autocmd('TermOpen', {
  group = statusline_group,
  callback = function()
    vim.wo.statusline = '%!v:lua.require\'statusline\'.print()'
  end,
})

-- Handle window focus
api.nvim_create_autocmd('FocusGained', {
  group = statusline_group,
  callback = function()
    vim.g.vim_in_focus = true
    vim.cmd('redrawstatus!')
  end,
})

api.nvim_create_autocmd('FocusLost', {
  group = statusline_group,
  callback = function()
    vim.g.vim_in_focus = false
    vim.cmd('redrawstatus!')
  end,
})

return M
