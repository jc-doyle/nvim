-- Taken/Adapted from akinsho/dotfiles
local fn = vim.fn
local api = vim.api
local M = {}

-- List of file types to use default fold text for
local fold_exclusions = { 'vim' }

local function preprocess(value)
  -- 1. Replace tabs
  local str = fn.substitute(value, '\t', string.rep(' ', vim.bo.tabstop), 'g')
  -- 2. getline returns the line leading white space so we remove it
  return fn.substitute(str, [[^\s*]], '', 'g')
end

local function handle_fold_start(start_text, end_text)
  start_text = preprocess(start_text)
  end_text = preprocess(start_text)
  local start_char = string.find(start_text, "{")
  local end_char = string.find(end_text, "}")
  if (start_char ~= nil) and (end_char ~= nil) then
    return string.gsub(start_text, '{','{·}')
  else
    return start_text
  end

end

function M.text()
  local line_end = fn.getline(vim.v.foldend)
  local line_start = fn.getline(vim.v.foldstart)
  local text = handle_fold_start(line_start, line_end, '  ')
  local numlines = vim.v.foldend - vim.v.foldstart + 1
  local count_text = numlines .. ' Lines ↓ '
  local indentation = fn.indent(vim.v.foldstart)
  local fold_start = string.rep(' ', indentation) .. text
  local fold_end = count_text .. string.rep(' ', 2)
  --NOTE: foldcolumn can now be set to a value of auto:Count e.g auto:5
  --so we split off the auto portion so we can still get the line count
  local parts = vim.split(vim.wo.foldcolumn, ':')
  local column_size = parts[#parts]
  local text_length = #fn.substitute(fold_start .. fold_end, '.', 'x', 'g') + column_size
  return fold_start .. string.rep(' ', api.nvim_win_get_width(0) - text_length - 4) .. fold_end
end

return M
