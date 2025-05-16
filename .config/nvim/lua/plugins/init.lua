return {
  "nvim-lua/plenary.nvim",
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- 'nvim-tree/nvim-web-devicons' },
    ft = "markdown",
    config = function()
      require('render-markdown').setup({
        heading = {
          icons = {},
        },
        render_modes = { 'n', 'c', 't', 'i', 'no' },
        quote = {
          icon = '|',
        },
        code = {
          border = 'thin',
        }
      })
      vim.keymap.set('n', '<leader>mt', function() require('render-markdown').buf_toggle() end, {})
    end
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },
  {
    "folke/zen-mode.nvim",
    -- event = "VeryLazy",
    lazy = true,
    opts = {
      window = {
        width = .70,
        backdrop = 1,
      }
    }
  },
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura_simple"
      vim.g.vimtex_imaps_enabled = 0
    end
  }
}
