return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  dependencies = {
    -- "nvim-treesitter/nvim-treesitter-textobjects",
    "kiyoon/nvim-treesitter-textobjects"
  },
  enable = false,
  run = ':TSUpdate',
  config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        highlight = { enable = true, },
        indent = { enable = true },
      }
  end
}

