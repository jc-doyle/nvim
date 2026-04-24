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

-- Toggle Statusbar
function M.toggle_status()
  vim.opt.ls = (vim.opt.ls:get()) % 2 + 1
end

function M.toggle_command()
  vim.opt.ch = (vim.opt.ch:get() + 1) % 2
end


function M.find_root()
  local root_markers = { ".git", "package.json", "Cargo.toml", "pyproject.toml", ".hg", "go.mod" }

  -- Try LSP root first
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in ipairs(clients) do
    if client.config.root_dir then
      return client.config.root_dir
    end
  end

  -- Fall back to root markers
  local dir = vim.fn.expand("%:p:h")
  while dir ~= "/" and dir ~= vim.fn.expand("~") do
    for _, marker in ipairs(root_markers) do
      if vim.fn.isdirectory(dir .. "/" .. marker) == 1
          or vim.fn.filereadable(dir .. "/" .. marker) == 1
      then
        return dir
      end
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  -- Final fallback
  return vim.fn.getcwd()
end

return M
