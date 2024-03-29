local opt = vim.opt

opt.termguicolors = true
opt.hidden = true
opt.wrap = false
opt.ignorecase = true
opt.cursorline = true
opt.splitbelow = true
opt.splitright = true
opt.mouse = "a"
opt.signcolumn = "auto"
opt.cursorcolumn = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 0
opt.pumheight = 10
opt.pumblend = 2
opt.updatetime = 250
opt.timeoutlen = 300
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.number = true
opt.numberwidth = 2
opt.scrolloff = 5
opt.background = "dark"
opt.relativenumber = true
opt.showmode = false
opt.completeopt = "menuone,noselect,preview,noinsert"
opt.winblend = 0
opt.guicursor = "n-v:block-Cursor,i-ci-c-o:ver10-iCursor,r:hor10-iCursor"
opt.shortmess = "filnxtToOFc"
opt.foldmethod = "expr"
opt.fillchars = {
  fold = ' ',
  eob = ' ',
  diff = '⣿', -- alternatives = ⣿ ░ ─
  msgsep = '‾',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldtext = "v:lua.require\'utils.fold\'.text()"
opt.foldlevel = 20

vim.g.python3_host_prog = "/usr/bin/python"
