cmp_icons = {
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
          -- Pull up all possible completions available
          ["<C-y>"] = cmp.config.disable,
          -- exit the completion window without choosing something
          ["<C-e>"] = cmp.mapping {
              i = cmp.mapping.abort(),
              c = cmp.mapping.close(),
              },
          -- choose an element in the list
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          -- iterate through the items with tab
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                 cmp.select_next_item()
            else
                 fallback()
            end
          end, {"i", "s"}),
          -- iterate back up with shift tab
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                 cmp.select_prev_item()
            else
                 fallback()
            end
          end, {"i", "s"}),
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

