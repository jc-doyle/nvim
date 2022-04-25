local lsp = vim.lsp

local signs = {
	Error = "",
	Warning = "",
	Hint = "",
	Information = ""
}

for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
end

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
	lsp.diagnostic.on_publish_diagnostics,
	{
		underline = true,
		signs = false,
		virtual_text = {prefix = "⠶", spacing = 1},
		update_in_insert = false
	}
)

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

-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
