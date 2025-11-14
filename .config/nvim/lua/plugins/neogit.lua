-- TODO refactor
return {
  {
    "sindrets/diffview.nvim",
    config = function()
      require('diffview').setup({
        use_icons = false,
        hooks = {
          diff_buf_read = function(bufnr)
            -- Change local options in diff buffers
            vim.opt_local.textwidth = 80
            vim.opt_local.linebreak = true
            vim.opt_local.breakindent = true
            vim.opt_local.wrap = true
            vim.opt_local.showbreak = "↪ "
          end,
        }
      })
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      -- "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    -- cmd = "Neogit",
    config = function()
      local neogit = require('neogit')
      -- local diffview = 
      neogit.setup({
        mappings = {
          popup = {
            ["F"] = "PullPopup",
            ["p"] = false,
            ["l"] = false,
            ["w"] = false,
            ["b"] = false,
            ["h"] = false,
          },
          rebase_editor = {
            ["<c-d>"] = "Abort",
            ["<c-c><c-k>"] = false,
          },
          commit_editor = {
            ["<c-d>"] = "Abort",
            ["<leader>gc"] = "Submit",
            ["<c-c><c-k>"] = false,
          },
        },
        kind = "split",
        commit_editor = {
          kind = "tab",
          show_staged_diff = true,
          staged_diff_split_kind = "split"
        },
      })

    end,
    keys = {
      { "<leader>gs", ":Neogit<cr>", desc = "Neogit" },
      { "<leader>gl", ":Neogit log<cr>", desc = "Neogit" },
    },
  }
}
