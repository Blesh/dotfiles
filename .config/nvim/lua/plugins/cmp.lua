return {
    "hrsh7th/nvim-cmp",
    event = 'InsertEnter',
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.2", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp"
        },
    },
    config = function()
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
                { name = 'buffer' },
                { name = 'luasnip' },
                { name = 'path' },
             },
             mapping = {
                 -- What exactly are you?
                 ["<C-y>"] = cmp.config.disable,
                 -- exit the completion window without choosing something
                 ["<C-e>"] = cmp.mapping {
                     i = cmp.mapping.abort(),
                     c = cmp.mapping.close(),
                     },
                 ['<CR>'] = cmp.mapping.confirm({ select = true }),
                 ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
                 ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
                 ['<C-o>'] = cmp.mapping(cmp.mapping.complete(), {'i','c'})
             },
             formatting = {
                  fields = {"kind", "abbr", "menu"},
                  format = function(entry, vim_item)
                    vim_item.kind = cmp_icons[vim_item.kind]
                    vim_item.menu = ({
                         nvim_lsp = "[LSP]",
                         buffer = "[Buffer]",
                         luasnip = "[Snippet]",
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

