if exists('g:vscode')
else
  " Plugins
  source ~/.config/nvim/plugins.vim

  " Plug Settings
  source ~/.config/nvim/plug-config/coc.vim
  source ~/.config/nvim/plug-config/markdown.vim
  source ~/.config/nvim/plug-config/ultisnips.vim
  source ~/.config/nvim/plug-config/vimtex.vim
  source ~/.config/nvim/plug-config/nord.vim
  source ~/.config/nvim/plug-config/lightline.vim
  source ~/.config/nvim/plug-config/mkdx.vim
  source ~/.config/nvim/plug-config/floaterm.vim

  " General
  source ~/.config/nvim/settings.vim

  " Keymaps
  source ~/.config/nvim/keymaps/which-key.vim
  source ~/.config/nvim/keymaps/mappings.vim

  "Startify
  source ~/.config/nvim/plug-config/startify.vim
endif
