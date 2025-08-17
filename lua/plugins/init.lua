local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      require("plugins.configs.treesitter")
    end,
    -- event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    -- cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-refactor"
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      opt = true
    },
    opts = function()
      require("plugins.configs.tree")
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      keys = {
        q = 'close',
        ["<cr>"] = 'jump_close',
        i = 'jump'
      }
    }
  },
  {
    "voldikss/vim-floaterm",
    init = function()
      require("plugins.configs.floaterm")
    end,
  },
  {
    "romgrk/barbar.nvim",
    config = function()
      require("plugins.configs.bufferline")
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
    event = { "BufRead" },
  },
  -- Git integration for buffers
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    init = function()
      require("plugins.configs.gitsigns")
    end,
  },
  -- LSP
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function()
      require("plugins.configs.mason")
    end
  },
  {
    "williamboman/mason-lspconfig.nvim"
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      }
    },
    cmd = "Telescope",
    config = function(_)
      require("telescope").setup()
      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("fzf")
      require("plugins.configs.telescope")
    end
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require("plugins.configs.luasnip")
        end,
      },

      {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-emoji",
      },
    },
    init = function()
      require("plugins.configs.completion")
    end,
  },
  {
    "notjedi/nvim-rooter.lua",
    init = function()
      require('nvim-rooter').setup { fallback_to_parent = true }
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function(_)
      require("colorizer").setup()

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.configs.which-key")
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    init = function()
      require("plugins.configs.scrollbar")
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    init = function()
      require("plugins.configs.spectre")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    {
      "ray-x/lsp_signature.nvim",
      version = false,
      event = "InsertEnter",
      opts = {
        floating_window = false,
      },
    }
  },

  { "tpope/vim-surround" },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    init = function()
      require("plugins.configs.quickfix")
    end,
  },
}

require("lazy").setup({
  spec = { plugins },
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
  defaults = {
    lazy = false,                                           -- should plugins be lazy-loaded?
    version = "*",                                          -- enable this to try installing the latest stable versions of plugins
  },
  ui = {
    icons = {
      ft = "  ",
      lazy = " 󰂠 ",
      loaded = "  ",
      not_loaded = "  "
    }
  },
  install = {
    -- install missing plugins on startup
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "default" }
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    -- get a notification when new updates are found
    -- disable it as it's too annoying
    notify = false,
    -- check for updates every day
    frequency = 86400
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    -- get a notification when changes are found
    -- disable it as it's too annoying
    notify = false
  },
  performance = {
    cache = {
      enabled = true
    }
  },
  state = vim.fn.stdpath("state") .. "/lazy/state.json" -- state info for checker and other things
})
