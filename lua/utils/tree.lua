local bufferline = require('bufferline.api')
local tree = require('nvim-tree.api').tree

local M = {}

function M.toggle()
	if tree.win_open() then
		tree.close()
		bufferline.set_offset(0)
	else
		bufferline.set_offset(30)
    tree.toggle()
	end
end

return M
