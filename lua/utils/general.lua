local M = {}

-- Create augroup
function M.augroup(autocmds, name)
	vim.cmd('augroup ' .. name)
	vim.cmd('autocmd!')

	for _, autocmd in ipairs(autocmds) do
		vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
	end

	vim.cmd('augroup END')
end

function M.autocmd(event, pattern, cmd)
	vim.cmd('autocmd ' .. event .. ' ' .. pattern .. ' ' .. cmd)
end

function _G.P(args)
	print(vim.inspect(args))
end

-- Toggle Statusbar
function _G.toggle_status()
	vim.opt.ls = (vim.opt.ls:get()) % 2 + 1
end

function _G.toggle_command()
	vim.opt.ch = (vim.opt.ch:get() + 1) % 2
end

return M
