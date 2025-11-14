-- TODO refactor
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true,
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          include_surrounding_whitespace = false,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['isl'] = '@assignment.lhs',
            ['isr'] = '@assignment.rhs',
            -- Not really neccessary considring ci(...
            -- ['ifn'] = '@fn.name',
            -- ['ifp'] = '@fn.param',
            ['ii'] = '@call.inner',
            ['at'] = '@class.outer',
            ['it'] = '@class.inner',
            ['ab'] = '@block.outer',
            ['ib'] = '@block.inner',
            ['ar'] = '@parameter.outer',
            ['ir'] = '@parameter.inner',
            ['ac'] = '@conditional.outer',
            ['ic'] = '@conditional.inner',
            ['afb'] = '@function.outer',
            ['ifb'] = '@function.inner',
            ['il'] = '@loop.inner',
            ['al'] = '@loop.outer',
          },
          selection_modes = {
            ['@block.inner'] = 'V', -- linewise
            ['@block.outer'] = 'V', -- linewise
            ['@loop.inner'] = 'V', -- linewise
            ['@loop.outer'] = 'V', -- linewise
            ['@conditional.outer'] = 'V', -- linewise
            ['@function.outer'] = 'V', -- linewise
            ['@function.inner'] = 'V', -- linewise
            ['@class.outer'] = 'V', -- linewise
            ['@class.inner'] = 'V', -- linewise
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ['mf'] = '@function.outer',
            ['mp'] = '@parameter.inner',
            ['mt'] = '@class.outer',
            ['mc'] = '@conditional.outer',
            ['mb'] = '@block.outer',
            ['ml'] = '@assignment.lhs',
            ['mr'] = '@assignment.rhs',
          },
          goto_previous_start = {
            ['mF'] = '@function.outer',
            ['mP'] = '@parameter.inner',
            ['mT'] = '@class.outer',
            ['mC'] = '@conditional.outer',
            ['mB'] = '@block.outer',
            ['mL'] = '@assignment.lhs',
            ['mR'] = '@assignment.rhs',
          },
        },
        swap = {
          enable = true,
          -- TODO are these useful at all?
          swap_next = {
            ["<leader>mp"] = "@parameter.inner",
            ["<leader>mc"] = "@conditional.inner",
          },
          swap_previous = {
            ["<leader>mP"] = "@parameter.inner",
            ["<leader>mC"] = "@conditional.inner",
          },
        },
        lsp_interop = {
          enable = true,
          floating_preview_opts = { border = 'single' },
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dT"] = "@class.outer",
          },
        },
      },
    })
    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    local gs = require("gitsigns")
    local next_hunk_repeat, _ = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
    vim.keymap.set({ "n", "x", "o" }, "<leader>nh", next_hunk_repeat)

    -- TODO Will always shwo an error when first opening something without errors as now call functions
    local next_diag, _ = ts_repeat_move.make_repeatable_move_pair(
      function() vim.diagnostic.jump({count = 1, float = true}) end,
      function() vim.diagnostic.jump({count = -1, float = true}) end
    )
    vim.keymap.set({ "n", "x", "o" }, "[d", next_diag)
    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}

