return {
  "nvim-treesitter/nvim-treesitter",
  --event = { "BufReadPre", "BufNewFile" },
  event = "VeryLazy",
  dependencies = {
    -- "nvim-treesitter/nvim-treesitter-textobjects",
    "kiyoon/nvim-treesitter-textobjects"
  },
  run = ':TSUpdate',
  config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        highlight = { enable = true, },
        indent = { enable = true },
      }
  end
}

