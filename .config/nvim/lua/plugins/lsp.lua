return {
  { "neovim/nvim-lspconfig", },
  {
     "williamboman/mason.nvim",
      -- TODO why is this necessary, otherwise lsps will not be properly found, why is lazy = false
     config = function()
       require("mason").setup()
     end
  },
  {
    "b0o/SchemaStore.nvim", lazy = true, version = false
  },
  {
    "ray-x/lsp_signature.nvim",
    -- event = "VeryLazy",
    event = "InsertEnter",
    opts = {
      hint_enable = false,
      doc_lines = 0,
      max_width = 100,
    },

    config = function(_, opts)
      require'lsp_signature'.setup(opts)
      vim.keymap.set({ 'i' }, '<c-s>',
        function()
          require('lsp_signature').toggle_float_win()
        end,
      { silent = true, noremap = true, desc = 'toggle signature' })
    end
  }
}

