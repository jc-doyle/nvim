local d = vim.diagnostic

local function upper(str)
  return (str:gsub("^%l", string.upper))
end

-- Filter specific diagnostics (e.g remove error codes)
local function filter(diagnostic)
  local m = diagnostic.message
  if vim.bo.filetype == 'python' then
    if diagnostic.source == 'pycodestyle' then
      return upper(m:gsub("^.-%s", "", 1))
    end
  end
  return m
end

d.config({
  underline = false,
  signs = false,
  virtual_text = { prefix = "•", format = filter, spacing = 3 },
  severity_sort = {
    reverse = false
  }
})

require 'trouble'.setup({
  action_keys = {
    close = { "q", "<esc>" },
  },
})

-- Add to global namesapce for keybinds
