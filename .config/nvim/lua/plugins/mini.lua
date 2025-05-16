return {
  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup({
        mappings = {
          go_in = 'L',
          go_in_plus = '',
          go_out = 'H',
          go_out_plus = '',
        }
      })
    end,
    vim.keymap.set('n', '<leader>e', '<cmd>lua = MiniFiles.open()<CR>')
  },
  {
    "echasnovski/mini.icons",
    config = function()
      require("mini.icons").setup({
        default = {
          directory = { hl = 'MiniIconsYellow' },
        },
        directory = {
          nvim = { hl = 'MiniIconsYellow' },
        },
      })
    end,
  },
  {
    'echasnovski/mini.comment', version = '*',
    event = "VeryLazy",
    config = function()
      require('mini.comment').setup()
    end,
  },
  {
      'echasnovski/mini.surround',
      version = '*',
      event = "VeryLazy",
      lazy = true,
      config = function()
          require('mini.surround').setup()
      end
  },
}
