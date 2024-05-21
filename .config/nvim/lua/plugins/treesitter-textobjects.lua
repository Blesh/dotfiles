return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true,
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ['[m'] = '@function.outer',
            },
            goto_previous_start = {
              [']m'] = '@function.outer',
            },
          },
          -- swap = {
          --   enable = true,
          --   swap_next = {
          --     ["<leader>a"] = "@parameter.inner",
          --   },
          --   swap_previous = {
          --     ["<leader>A"] = "@parameter.inner",
          --   },
          -- },
          --lsp_interop = {
          --  enable = true,
          --  border = 'none',
          --  floating_preview_opts = {},
          --  peek_definition_code = {
          --    ["<leader>df"] = "@function.outer",
          --    ["<leader>dF"] = "@class.outer",
          --  },
          --},
      },
    })
    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  end,
}

