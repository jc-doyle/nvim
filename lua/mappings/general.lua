local options = {noremap = true, silent = true}

local function m(mode, lhs, rhs, cr)
  if cr == nil then
    rhs = '<cmd>'.. rhs .. '<cr>'
  end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function n(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Buffer Related
m('n', '<TAB>', 'BufferNext')
m('n', '<s-TAB>', 'BufferPrevious')
m('n', '<A-TAB>', 'BufferPick')
m('n', '<TAB>', 'BufferNext')
m('n', '<A-.>', 'BufferMoveNext')
m('n', '<A-,>', 'BufferMovePrevious')

m('n', '<C-q>', 'lua require"utils.close".close()')

-- Window Movement
m('n', '<S-A-j>', 'resize +1')
m('n', '<S-A-k>', 'resize -1')
m('n', '<S-A-l>', 'vertical resize +1')
m('n', '<S-A-h>', 'vertical resize -1')

m('n', '<A-j>', 'wincmd j')
m('n', '<A-k>', 'wincmd k')
m('n', '<A-l>', 'wincmd l')
m('n', '<A-h>', 'wincmd h')

m('n', '<C-A-j>', 'resize 28')
m('n', '<C-A-k>', 'resize 8')

m('t', '<A-k>', 'wincmd k')
m('t', '<C-A-k>', 'resize 25')
m('t', '<C-A-j>', 'resize 8')

m('n', '<A-v>', 'vsp')
m('n', '<A-n>', 'sp')

m('v', '<', '<gv', false)
m('v', '>', '>gv', false)

-- Terminal
m('n', '<C-Enter>', 'lua require "utils.terminal".toggle()')
m('t', '<C-Enter>', 'lua require "utils.terminal".toggle()')
-- map('t', '<leader>q', 'lua require "utils.terminal".toggle()')

m('n', '<C-Bslash>', 'lua require "utils.shell".toggle()')
m('t', '<C-Bslash>', 'lua require "utils.shell".toggle()')

-- map('t', '<leader>D', 'lua require "dap".step_over()')
m('t', '<C-n>', 'stopinsert')

-- Dont overwrite clipboard
n('n', 'x', '"_x')

-- Saving/Quitting
m('n', '<C-s>', 'w')

-- Open Link
m('n', 'gx', 'call jobstart(["xdg-open", expand("<cfile>")])')

-- Scroll Docs
m('i', '<C-S-j>', 'lua require"cmp".scroll_docs(2)')
m('i', '<C-S-k>', 'lua require"cmp".scroll_docs(-2)')


