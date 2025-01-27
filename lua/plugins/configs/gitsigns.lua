local config = {
  signs = {
    add = {
      text = '│',
    },
    change = {
      text = '│',
    },
    delete = {
      text = '│',
    },
    topdelete = {
      text = '│',
    },
    changedelete = {
      text = '│',
    },
  },
  numhl = true,
  linehl = false,
  signcolumn = false,
  watch_gitdir = { interval = 1000, follow_files = true },
  current_line_blame = false,
  -- Use default
  word_diff = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
    delay = 1000,
    ignore_whitespace = false
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1
  }
}

require('gitsigns').setup(config)
