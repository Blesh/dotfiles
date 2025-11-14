return {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp"
    },
    { 'saadparwaiz1/cmp_luasnip' }
  },
  config = function()
    -- https://github.com/tjdevries/config.nvim/blob/master/lua/custom/snippets.lua
    local ls = require "luasnip"
    vim.snippet.expand = ls.lsp_expand

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.snippet.active = function(filter)
      filter = filter or {}
      filter.direction = filter.direction or 1

      if filter.direction == 1 then
        return ls.expand_or_jumpable()
      else
        return ls.jumpable(filter.direction)
      end
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.snippet.jump = function(direction)
      if direction == 1 then
        if ls.expandable() then
          return ls.expand_or_jump()
        else
          return ls.jumpable(1) and ls.jump(1)
        end
      else
        return ls.jumpable(-1) and ls.jump(-1)
      end
    end

    vim.snippet.stop = ls.unlink_current

    ls.config.set_config {
      -- be abe to jump back into last snippet
      history = true,
      updateevents = "TextChanged,TextChangedI",
      override_builtin = true,
    }

    for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("snippets/*.lua", true)) do
      loadfile(ft_path)()
    end

    -- TODO Since 0.11 update and luasnip version pump I have random jumps when pressing tab from time to time
    -- which I'm assuming is due to LuaSnip default keymaps which I see when I type `:verbose imap <Tab>`. Let's try
    -- to work around it for now by deleting those bindings
    vim.keymap.del({"i","s"}, "<Tab>")
    vim.keymap.del({"i","s"}, "<S-Tab>")
    vim.keymap.set({ "i", "s" }, "<c-j>", function()
      return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<c-k>", function()
      return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
    end, { silent = true })

    local cmp_icons = {
      Text = '',
      Method = '',
      Function = '󰊕',
      Constructor = '',
      Field = '',
      Variable = '',
      Class = '󰠱',
      Interface = '',
      Module = '󰏓',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '',
      EnumMember = '',
      Keyword = '󰌋',
      Snippet = '󰲋',
      Color = '',
      File = '',
      Reference = '',
      Folder = '',
      Constant = '󰏿',
      Struct = '󰠱',
      Event = '',
      Operator = '',
      TypeParameter = '󰘦',
      Unknown = '',
    }
    local cmp = require'cmp'
    cmp.setup({
      snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end, },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      },
      mapping = {
        ["<CR>"] = cmp.mapping( cmp.mapping.confirm
        { behavior = cmp.ConfirmBehavior.Insert, select = true, }, { "i", "c" }),
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        -- exit the completion window without choosing something
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ['<C-o>'] = cmp.mapping(cmp.mapping.complete(), {'i','c'})
      },
      formatting = {
        fields = {"kind", "abbr", "menu"},
        format = function(entry, vim_item)
          vim_item.kind = cmp_icons[vim_item.kind]
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]

          return vim_item
        end,
      },
      -- completion = {
      --   completeopt = 'menu,menuone,noinsert',
      -- },
      window = {
       documentation = cmp.config.window.bordered(),
      },
    })
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      -- mapping = cmp.mapping.preset.cmdline(),
      -- mapping = {
      --   ["<CR>"] = cmp.mapping( cmp.mapping.confirm
      --   { behavior = cmp.ConfirmBehavior.Insert, select = false, }, { "i", "c" }),
      --   ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      --   ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      --   -- exit the completion window without choosing something
      --   ["<C-e>"] = cmp.mapping {
      --     i = cmp.mapping.abort(),
      --     c = cmp.mapping.close(),
      --   },
      --   ['<C-o>'] = cmp.mapping(cmp.mapping.complete(), {'i','c'})
      -- },
      mapping = cmp.mapping.preset.cmdline({
          ["<C-n>"] = { c = cmp.mapping.select_next_item() },
          ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
          ["<CR>"]  = { c = cmp.mapping.confirm({ select = false }) },
      }),
      sources = {
        { name = 'buffer' }
      }
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      -- https://github.com/hrsh7th/cmp-cmdline/issues/108#issuecomment-2052449375
      mapping = cmp.mapping.preset.cmdline({
          ["<C-n>"] = { c = cmp.mapping.select_next_item() },
          ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
          ["<CR>"]  = { c = cmp.mapping.confirm({ select = false }) },
      }),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })
  end
}

