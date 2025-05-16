local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed } end
end

local function parent_folder()
  local parent = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h:t')
  return parent ~= '.' and parent .. '/' or ''
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    -- Required to properly set the colors.
    local c = require 'meinz-scheme.colors'
    require('lualine').setup {
      sections = {
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = {
          {
            parent_folder,
            color = { fg = c.white_01 },
            icon = { '  ', color = { fg = c.white_01 } },
            separator = '',
            padding = 0,
          },
          {
            'filename',
            color = { fg = c.white_01 },
            separator = ' ',
            padding = 0,
          },
          {
            'branch',
            color = { fg = c.white_01 },
            icon = { '  ', color = { fg = c.white_01 } },
            separator = ' ',
            padding = 0,
          },
          {
            'diff',
            padding = 0,
            colored = true,
            color = { ctermfg = c.white_01 },
            icon = { ' ', color = { ctermfg = c.black_01 } },
            source = diff_source,
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            diff_color = {
                added = { fg = c.green },
                modified = { fg = c.cyan },
                removed = { fg =  c.red },
            },
          },
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = '󱤅 ', other = '󰠠 ' },
            diagnostics_color = {
              error = { fg = c.red },
              warn  = { fg = c.orange },
              info  = { fg = c.yellow },
              hint  = { fg = c.green },
            },
            colored = true,
            padding = 1,
          },
          {
            'lsp_status',
            padding = 2,
            symbols = { separator = ' ', done = ' ' },
            color = { fg = c.white_02 },
            icon = { '', color = { fg = c.white_01 } },
          },
        },
        lualine_y = {},
        lualine_z = {
          {
            'location',
            icon = { '', align = 'left', color = { fg = c.white_01 } },
          },
          {
            'progress',
            icon = { '', align = 'left', color = { fg = c.white_01 } },
          },
        },
      },
      options = {
        theme = 'meinz-scheme',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        globalstatus = true,
      },
    }
  end
}
