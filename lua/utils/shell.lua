local M = {}
local api = vim.api

local utils = require 'utils.general'
local shell_cmd = {python = '/usr/bin/python'}

local shell = {bufnum = nil, window = nil}

function M.is_open()
	local wins = api.nvim_list_wins()
	for _, win in pairs(wins) do
		local buf = api.nvim_win_get_buf(win)
		if buf == shell.bufnum then
			shell.window = win
			return true
		end
	end
	return false
end

local function find_buf_by_name(name)
	local bufs = api.nvim_list_bufs()
	for _, buf in pairs(bufs) do
		if name == api.nvim_buf_get_name(buf) then
			return buf
		end
	end
end

local function create()
	local ft = vim.bo.filetype
	if shell_cmd[ft] then
		vim.fn.termopen(shell_cmd[ft])
	end
end

local function create_or_show()
	vim.cmd("botright 10split")
	local current_win = api.nvim_get_current_win()
	if (shell.bufnum == nil) or not api.nvim_buf_is_valid(shell.bufnum) then
		shell.bufnum = api.nvim_create_buf(false, false)
		api.nvim_win_set_buf(current_win, shell.bufnum)
		create()
	else
		api.nvim_win_set_buf(current_win, shell.bufnum)
	end
end

local function start_r()
	if not vim.g.rplugin.R_bufname then
		vim.cmd('call StartR("R")')
		shell.bufnum = find_buf_by_name(vim.g.rplugin.R_bufname)
	else
		create_or_show()
	end
end

function M.toggle()
	if M.is_open() then
		api.nvim_win_close(shell.window, true)
	elseif vim.g.rplugin then
		start_r()
	else
		create_or_show()
	end
end

--[[ function M.resize()
  if is_open() then
    vim.bo[terminal.bufnum]
  end ]]

utils.augroup(
	{
		{'BufWinEnter,WinEnter,TermOpen', 'term://*', 'startinsert'},
	},
	'terminal'
)

return M
