require('gitsigns').setup {
	signs = {
		add = {
			hl = 'GitSignsAdd',
			text = '│',
		},
		change = {
			hl = 'GitSignsChange',
			text = '│',
		},
		delete = {
			hl = 'GitSignsDelete',
			text = '│',
		},
		topdelete = {
			hl = 'GitSignsDelete',
			text = '│',
		},
		changedelete = {
			hl = 'GitSignsChange',
			text = '│',
		},
	},
	numhl = true,
	linehl = false,
	signcolumn = false,
	watch_gitdir = {interval = 1000, follow_files = true},
	current_line_blame = false,
	current_line_blame_opts = {
		delay = 1000,
		virt_text_pos = 'eol',
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil,

	-- Use default
	word_diff = false,
}
