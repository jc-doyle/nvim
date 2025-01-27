local config = {
  animation = true,
  auto_hide = false,
  closable = true,
  clickable = true,
  exclude_ft = { 'rbrowser', 'qf' },
  maximum_padding = 0,
  maximum_length = 30,
  semantic_letters = true,
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
  no_name_title = nil,
  tabpages = false,
  focus_on_close = 'left',
  hide = { extensions = true, inactive = false },
  highlight_alternate = false,
  highlight_inactive_file_icons = false,
  highlight_visible = true,
  icons = {
    buffer_index = false,
    buffer_number = false,
    scroll = { left = '⊲ ', right = ' ⊳' },
    button = '×',
    filetype = {
      custom_colors = true,
      enabled = true,
    },
    current = {
      buffer_index = false,
      scroll = { left = '⊲', right = '⊳' },
    },
    separator = { left = ' ', right = ' ' },
    inactive = {
      button = '×',
      separator = { left = ' ', right = ' ' },
      scroll = { left = '⊲', right = '⊳' },
    },
    modified = { button = '·' },
    pinned = { button = '=' },
    alternate = { filetype = { enabled = false } },
    visible = { modified = { buffer_number = false } },
  },

  sidebar_filetypes = {
    NvimTree = true,
  },
}

-- return config
require('barbar').setup(config)
