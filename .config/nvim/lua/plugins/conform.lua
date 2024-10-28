return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- Conform will run multiple formatters sequentially
        python = { "ruff_organize_imports", "ruff_format" },
        rust = { "rustfmt" },
      },
    })
  end
}
