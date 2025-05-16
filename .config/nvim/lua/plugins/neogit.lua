-- TODO refactor
return {
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
    local diffview = require('diffview')
    diffview.setup()
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
