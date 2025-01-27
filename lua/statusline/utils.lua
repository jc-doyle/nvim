local M = {}

M.mode_alias = {
  ['n']    = 'n',
  ['no']   = 'n',
  ['nov']  = 'n',
  ['noV']  = 'n',
  ['no'] = 'n',
  ['niI']  = 'n',
  ['niR']  = 'n',
  ['niV']  = 'n',
  ['nt']   = 'n',  -- Terminal normal mode
  ['v']    = 'v',
  ['vs']   = 'v',
  ['V']    = 'v',
  ['Vs']   = 'v',
  ['']   = 'v',
  ['s']    = 's',
  ['S']    = 's',
  ['']   = 's',
  ['i']    = 'i',
  ['ic']   = 'i',
  ['ix']   = 'i',
  ['R']    = 'r',
  ['Rc']   = 'r',
  ['Rv']   = 'r',
  ['Rx']   = 'r',
  ['r']    = 'r',
  ['rm']   = 'r',
  ['r?']   = 'r',
  ['c']    = 'c',
  ['cv']   = 'c',
  ['ce']   = 'c',
  ['t']    = 't',  -- Terminal mode
  ['!']    = 't',  -- Shell/external command
  ['null'] = 'n',
}

function M.mode_hl()
  local mode = M.mode_alias[vim.api.nvim_get_mode().mode] or 'n'
  if mode == 'v' then
    return 'StVisual'
  elseif mode == 's' then
    return 'StSelect'
  elseif mode == 'i' then
    return 'StInsert'
  elseif mode == 'r' then
    return 'StReplace'
  elseif mode == 'c' then
    return 'StCommand'
  elseif mode == 't' then
    return 'StCommand'  -- Use command highlight for terminal
  else
    return 'StNormal'
  end
end

function M.lsp_active()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  return #clients > 0
end

function M.icon()
  return "  "
end

-- Updated diagnostics functions to use newer API
function M.get_diagnostics_count(severity)
  return #vim.diagnostic.get(0, { severity = severity })
end

function M.diagnostics_exist(severity)
  return M.get_diagnostics_count(severity) > 0
end

return M
