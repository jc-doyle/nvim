vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.vim_in_focus = true
vim.g.vsnip_snippet_dir = vim.fn.stdpath('config')..'/snippets'
vim.g.loaded_netrw = 0
vim.g.loaded_matchparen = 1

require "settings"
require "plugins"
require "mappings"
require "statusline"

-- colorscheme
vim.cmd('colorscheme default')
