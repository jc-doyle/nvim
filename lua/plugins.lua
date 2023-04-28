local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

local packer = require("packer")
local use = packer.use

return packer.startup(function()
  use "wbthomason/packer.nvim"

  -- LSP & Related ----------------------------------------
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp")
    end
  }

  use {
    "folke/trouble.nvim",
    config = function()
      require("lsp.diagnostics")
    end
  }

  use {
    "mhartington/formatter.nvim",
    config = function()
      require("lsp.format")
    end,
    cmd = "FormatWrite",
  }

  use {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  }

  -- use "jubnzv/virtual-types.nvim"

  -- Completion & Snippets --------------------------------------------
  use {
    "yioneko/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "f3fora/cmp-spell",
      "jc-doyle/cmp-latex-symbols",
      "jc-doyle/cmp-pandoc-references",
      "saadparwaiz1/cmp_luasnip",
      "piero-vic/cmp-ledger"
    },
    config = function()
      require("plugin-settings.completion")
    end,
  }
  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugin-settings.snippets")
    end,
  }

  -- Tree Sitter ------------------------------------------------------
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugin-settings.treesitter")
    end
  }
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "nvim-treesitter/playground"
  use "nvim-treesitter/nvim-treesitter-refactor"

  -- Git --------------------------------------------------------------
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugin-settings.gitsigns")
    end,
    event = "BufRead"
  }
  use "tpope/vim-fugitive"

  -- use "abecodes/tabout.nvim"

  -- Editing Functionality --------------------------------------------
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  }

  use {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end,
    event = "BufRead",
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("plugin-settings.autopairs")
    end,
    after = "nvim-cmp",
  }

  use {
    "monkoose/matchparen.nvim",
    config = function()
      require("matchparen").setup({ hl_group = 'MatchParen' })
    end
  }

  use "tpope/vim-surround"
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"
  use "tjdevries/colorbuddy.nvim"
  use "preservim/vim-pencil"

  -- Debug -----------------------------------------------------------
  use {
    "mfussenegger/nvim-dap",
    config = function()
      require("plugin-settings.debug")
    end
  }

  use "theHamsta/nvim-dap-virtual-text"

  -- Terminal --------------------------------------------------------
  use {
    "voldikss/vim-floaterm",
    config = function()
      require("plugin-settings.floaterm")
    end
  }

  -- UI/Tools --------------------------------------------------------
  use {
    "folke/which-key.nvim",
    config = function()
      require("plugin-settings.which-key")
    end,
  }
  use {
    "romgrk/barbar.nvim",
    config = function()
      require("plugin-settings.bufferline")
    end,
  }
  use {
    "Xuyuanp/scrollbar.nvim",
    config = function()
      require("plugin-settings.scrollbar")
    end
  }
  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("plugin-settings.outline")
    end,
    lock = true,
    cmd = "SymbolsOutline"
  }
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("plugin-settings.telescope")
    end
  }
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugin-settings.filetree")
    end
  }
  use {
    "kevinhwang91/nvim-bqf",
    config = function()
      require("plugin-settings.quickfix")
    end
  }
  use "kyazdani42/nvim-web-devicons"
  use "junegunn/goyo.vim"
  use "SmiteshP/nvim-gps"
  use { "tweekmonster/startuptime.vim", cmd = "StartupTime" }

  -- Language Specific -----------------------------------------------
  use "Vimjas/vim-python-pep8-indent"

  -- use "lervag/vimtex"
  use "jalvesaq/Nvim-R"
  use "mfussenegger/nvim-jdtls"
  use "ledger/vim-ledger"
end)
