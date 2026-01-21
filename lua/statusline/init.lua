-- A groovy status line
local s = require 'statusline.components'
local utils = require 'statusline.utils'

local api = vim.api
local M = {}

-- 1. Buffers that get a blank, highlighted line (StatusLineNC)
local force_nc = {
  buftypes = { 'terminal', 'quickfix' },
  filetypes = { 'NvimTree', 'trouble', 'Outline' },
  bufnames = {}
}

-- 2. Buffers that get NO statusline at all (render nothing)
local force_hide = {
  buftypes = {},
  filetypes = { 'TelescopePrompt', 'TelescopeResults', 'floaterm' },
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

-- Updated to accept win_id to check for floating windows
local function get_status_mode(bufnr, winnr)
  local buftype = vim.bo[bufnr].bt
  local filetype = vim.bo[bufnr].ft
  local bufname = vim.fn.bufname(bufnr)

  -- 1. Force Hide (Explicit config)
  if vim.tbl_contains(force_hide.buftypes, buftype)
      or vim.tbl_contains(force_hide.filetypes, filetype)
      or vim.tbl_contains(force_hide.bufnames, bufname) then
    return 'hide'
  end

  -- 2. Force NC (Explicit config)
  if vim.tbl_contains(force_nc.buftypes, buftype)
      or vim.tbl_contains(force_nc.filetypes, filetype)
      or vim.tbl_contains(force_nc.bufnames, bufname) then
    return 'nc'
  end

  -- 3. Catch-all for Floating Windows
  -- If it's a float and hasn't been handled above, hide it.
  local config = api.nvim_win_get_config(winnr)
  if config.relative and config.relative ~= "" then
    return 'hide'
  end

  return 'standard'
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

  return generate(context)
end

local function update_statusline(win_id)
  local win = win_id or api.nvim_get_current_win()
  local buf = api.nvim_win_get_buf(win)

  -- Pass win ID to check for floating status
  local mode = get_status_mode(buf, win)

  if mode == 'hide' then
    vim.wo[win].statusline = nil
  elseif mode == 'nc' then
    vim.wo[win].statusline = '%#StatusLineNC#'
  else
    vim.wo[win].statusline = '%!v:lua.require\'statusline\'.print()'
  end
end

local statusline_group = api.nvim_create_augroup('statusline', { clear = true })

-- Added 'FileType' to catch late filetype changes (like in floaterm)
api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'VimEnter', 'FileType' }, {
  group = statusline_group,
  callback = function()
    if vim.fn.pumvisible() == 0 then
      update_statusline()
    end
  end,
})

api.nvim_create_autocmd('WinLeave', {
  group = statusline_group,
  callback = function()
    local win = api.nvim_get_current_win()
    update_statusline(win)
  end,
})

api.nvim_create_autocmd('TermOpen', {
  group = statusline_group,
  callback = function()
    update_statusline()
  end,
})

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
