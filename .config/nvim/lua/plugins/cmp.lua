return {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    -- lazy = false,
    -- priority = 100,
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

      vim.keymap.set({ "i", "s" }, "<c-k>", function()
        return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<c-j>", function()
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

         window = {
            documentation = cmp.config.window.bordered(),
         },
      })
    end
}

