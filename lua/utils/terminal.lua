local M = {}
local api = vim.api

local utils = require 'utils.general'
local os_shell = '/bin/zsh'

local terminal = {
	bufnum = nil,
	window = nil,
}

function M.is_open()
	local wins = api.nvim_list_wins()
	for _, win in pairs(wins) do
		local buf = api.nvim_win_get_buf(win)
		if buf == terminal.bufnum then
			terminal.window = win
			return true
		end
	end
	return false
end

local function create()
	vim.fn.termopen(os_shell)
end

local function create_or_show()
	vim.cmd("botright 10split")
	local current_win = api.nvim_get_current_win()
	if (terminal.bufnum == nil) or not api.nvim_buf_is_valid(terminal.bufnum) then
		terminal.bufnum = api.nvim_create_buf(false, false)
		api.nvim_win_set_buf(current_win, terminal.bufnum)
		create()
	else
		api.nvim_win_set_buf(current_win, terminal.bufnum)
	end
end

function M.toggle()
	if M.is_open() then
		api.nvim_win_close(terminal.window, true)
	else
		create_or_show()
	end
end

return M
