local d = vim.diagnostic

d.config({
  underline = false,
  signs = false,
  virtual_text = {
    prefix = "⠶",
    spacing = 3
  }
})

local signs = {
	Error = '',
	Warning = '',
	Hint = '',
	Information = ''
}

for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
end


require 'trouble'.setup({
	use_diagnostic_signs = true,
	indent_lines = false,
	auto_close = true,
	icons = false,
	action_keys = {
		cancel = {},
		close = {"q", "<esc>"},
	}
})

