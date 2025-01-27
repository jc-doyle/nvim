local cmp = require "cmp"

require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua = { "string" }, -- it will not add a pair on that treesitter node
    javascript = { "template_string" },
    java = false        -- Don't check treesitter on java
  },

  -- Don't add pairs if it already has a close pair in the same line
  enable_check_bracket_line = false,

  -- Don't add pairs if the next char is alphanumeric
  ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" }
})

-- setup cmp for autopairs
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

local function border(hl_name)
  return { { "╭", hl_name }, { "─", hl_name }, { "╮", hl_name }, { "│", hl_name }, { "╯", hl_name },
    { "─", hl_name }, { "╰", hl_name }, { "│", hl_name } }
end

local LspItemKind = {
  Text = " Text",
  Method = "󰆧 Method",
  Function = "󰊕 Function",
  Constructor = " Constructor",
  Field = " Field",
  Variable = " Variable",
  Class = "󰠱 Class",
  Interface = " Interface",
  Module = " Module",
  Property = "󰜢 Property",
  Unit = " Unit",
  Value = "󰎠 Value",
  Enum = "󰙅 Enum",
  Keyword = "󰌋 Keyword",
  Snippet = " Snippet",
  Color = "󰏘 Color",
  File = "󰈙 File",
  Reference = " Reference",
  Folder = " Folder",
  EnumMember = "󰙅 EnumMember",
  Constant = " Constant",
  Struct = "󰙅 Struct",
  Event = " Event",
  Opertaor = "󰆕 Operator",
  TypeParameter = "󰅲 TypeParameter",
}

local function format_kind(entry, item)
  local source = entry.source.name
  item.kind = LspItemKind[item.kind]

  if source == 'buffer' then
    item.kind = " Buffer"
  elseif source == 'spell' then
    item.kind = " Spell"
  elseif source == 'ledger' then
    item.kind = " Account"
  elseif source == 'luasnip' then
    item.abbr = item.abbr
  elseif source == 'latex_symbols' then
    local result = {}
    for word in string.gmatch(item.abbr, "[^%s]+") do
      table.insert(result, word)
    end
    item.abbr = result[1]
    if result[2] ~= nil then
      item.kind = result[2] .. " Symbol"
    end
  elseif source == 'pandoc_references' then
    if not string.match(item.abbr, '(%w+):(%g+)') then
      item.kind = " Citation"
    end
  end

  return item
end

local function truncate(item)
  if string.len(item.abbr) > 24 then
    if string.sub(item.abbr, 23, 23) == "," then
      item.abbr = string.sub(item.abbr, 1, 23) .. "…  "
    else
      item.abbr = string.sub(item.abbr, 1, 22) .. "…  "
    end
  end

  return item
end

local function format(entry, item)
  item = truncate(item)
  item = format_kind(entry, item)
  return item
end


local options = {
  completion = {
    completeopt = "menu,menuone"
  },

  window = {
    completion = {
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
      scrollbar = false
    },
    documentation = {
      border = border "CmpDocBorder",
      winhighlight = "Normal:CmpDoc"
    }
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },

  formatting = {
    format = format,
  },

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true,
          true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
          "")
      else
        fallback()
      end
    end, { "i", "s" })
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    {
      name = "buffer",
      option = {
        -- Avoid accidentally running on big files
        get_bufnrs = function()
          local buf = vim.api.nvim_get_current_buf()
          local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
          if byte_size > 1024 * 1024 then -- 1 Megabyte max
            return {}
          end
          return { buf }
        end
      }
    },
    { name = "nvim_lua" },
    { name = "path" }
  }
}
cmp.setup(options)
