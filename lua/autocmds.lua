local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "Yank",
      timeout = "300"
    })
  end
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "",
  command = ":%s/\\s\\+$//e"
})

-- Auto format on save using the attached (optionally filtered) language servere clients
-- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
-- autocmd("BufWritePre", {
--   pattern = "",
--   command = ":silent lua vim.lsp.buf.format()"
-- })

-- Don"t auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o"
})

autocmd("Filetype", {
  pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "lua" },
  command = "setlocal shiftwidth=2 tabstop=2"
})

-- -- Set colorcolumn
-- autocmd("Filetype", {
--   pattern = { "python", "rst", "c", "cpp" },
--   command = "set colorcolumn=80"
-- })

autocmd("Filetype", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end
})

-- Terminal
augroup('TerminalCommands', { clear = true })

autocmd('TermOpen', {
  pattern = '*',
  group = 'TerminalCommands',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no' -- Hide the sign column
    vim.opt_local.statusline = ''   -- Hide the statusline
  end,
})

autocmd({ 'BufWinEnter', 'WinEnter', 'TermOpen' }, {
  pattern = 'term://*',
  group = 'TerminalCommands',
  command = 'startinsert', -- Enter insert mode
})

-- Quickfix
local function setup_qf_syntax()
    vim.cmd([[
        syn match qfFileName /^[^│]*/ nextgroup=qfSeparatorLeft
        syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
        syn match qfLineNr /[^│]*/ contained nextgroup=qfSeparatorRight
        syn match qfSeparatorRight '│' contained nextgroup=qfError,qfWarning,qfInfo,qfNote
        syn match qfError / E .*$/ contained
        syn match qfWarning / W .*$/ contained
        syn match qfInfo / I .*$/ contained
        syn match qfNote / [NH] .*$/ contained

        hi def link qfFileName Directory
        hi def link qfSeparatorLeft Delimiter
        hi def link qfSeparatorRight Delimiter
        hi def link qfLineNr LineNr
        hi def link qfError DiagnosticError
        hi def link qfWarning DiagnosticWarn
        hi def link qfInfo DiagnosticInfo
        hi def link qfNote DiagnosticHint
    ]])
end

-- Set up an autocommand to apply the syntax highlighting for 'qf' filetype
autocmd('FileType', {
    pattern = 'qf',
    callback = function()
        setup_qf_syntax()
        vim.bo.syntax = 'qf'  -- Set the syntax to 'qf'
    end,
})
