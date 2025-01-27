local config = {
  -- A list of parser names, or "all"
  ensure_installed = {
    "go", "python", "dockerfile", "json",
    "yaml", "markdown", "html", "scss",
    "css", "vim", "lua", "javascript", "svelte",
    "rust", "vimdoc", "luadoc", "vim",
    "lua", "markdown", "typescript"
  },

  autopairs = { enable = true },
  highlight = { enable = true, disable = { "c", "cpp", "r" } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = ".",
      node_incremental = ".",
      scope_incremental = "grc",
      node_decremental = ",",
    },
  },
  indent = { enable = false, disable = { "python", "javascript", "typescript" } },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  autotag = {
    enable = true
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false
  },
  refactor = {
    highlight_definitions = {
      enable = true
    },
    highlight_current_scope = {
      enable = false
    }
  }
}

require("nvim-treesitter.configs").setup(config)
