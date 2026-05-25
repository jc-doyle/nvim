-- Install parsers
local ENSURE_INSTALLED = {
  "angular",
  "arduino",
  "asm",
  "bash",
  "bibtex",
  "c",
  "c_sharp",
  "clojure",
  "cmake",
  "commonlisp",
  "cpp",
  "css",
  "csv",
  "dart",
  "diff",
  "dockerfile",
  "elixir",
  "elm",
  "erlang",
  "fortran",
  "fsharp",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "glsl",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "graphql",
  "groovy",
  "haskell",
  "hcl",
  "hlsl",
  "html",
  "http",
  "ini",
  "java",
  "javadoc",
  "javascript",
  "jinja",
  "jq",
  "jsdoc",
  "json",
  "json5",
  "jsx",
  "julia",
  "just",
  "kdl",
  "kotlin",
  "latex",
  "ledger",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "matlab",
  "mermaid",
  "meson",
  "nginx",
  "nix",
  "objc",
  "ocaml",
  "pascal",
  "pem",
  "perl",
  "php",
  "pkl",
  "promql",
  "proto",
  "r",
  "regex",
  "rst",
  "ruby",
  "rust",
  "scala",
  "scheme",
  "scss",
  "sql",
  "ssh_config",
  "svelte",
  "swift",
  "toml",
  "tsv",
  "tsx",
  "typescript",
  "typst",
  "vala",
  "vhdl",
  "vim",
  "vimdoc",
  "vue",
  "xml",
  "yaml",
  "zig",
  "zsh",
}
--
require("nvim-treesitter").install(ENSURE_INSTALLED)

-- Enable treesitter highlighting and indentation via FileType autocmd
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local ft = vim.bo.filetype
    -- skip filetypes where treesitter highlighting is disabled
    if vim.tbl_contains({ "r" }, ft) then
      return
    end

    -- Enable treesitter highlighting (pcall in case parser not installed)
    local ok = pcall(vim.treesitter.start)
    if ok then
      local lang = vim.treesitter.language.get_lang(ft)

      -- Check capabilitys & enable indents & folds
      if lang then
        -- if vim.treesitter.query.get(lang, 'indents') then
        --   vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        -- end

        if vim.treesitter.query.get(lang, 'folds') then
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end
      end

      -- Disable regex syntax highlighting
      vim.bo.syntax = ''
    end
  end,
})

-- Textobjects config
require("nvim-treesitter").setup({
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})

-- Incremental selection: . to grow, , to shrink
-- In normal mode: select the smallest node at cursor and enter visual
-- In visual mode: grow via an, shrink via in
vim.keymap.set("n", ".", function()
  local node = vim.treesitter.get_node()
  if not node then return end
  local sr, sc, er, ec = node:range()
  vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
  vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
  vim.cmd("normal! gv")
end, { desc = "TS: select current node" })
vim.keymap.set("x", ".", "an", { remap = true, desc = "TS: grow selection" })
vim.keymap.set("x", ",", "in", { remap = true, desc = "TS: shrink selection" })
