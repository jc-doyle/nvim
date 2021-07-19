-- Configure lua language server for neovim development
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local settings = {
	Lua = {
		runtime = {
			-- LuaJIT in the case of Neovim
			version = 'LuaJIT',
			path = runtime_path
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = {'vim'},
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = vim.api.nvim_get_runtime_file("", true),
		},
		telemetry = {
			enable = false,
		}
	}
}

return settings
