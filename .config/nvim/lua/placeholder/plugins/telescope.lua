-- Telescope configuration
local actions = require "telescope.actions"
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    prompt_prefix = '   ',
    selection_caret = '  ',
    layout_strategy = "vertical",
    mappings = {
      i = {
        ["<C-q>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab"] = actions.move_selection_previous,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        --["<C-u>"] = actions.results_scrolling_up,
        --["<C-d>"] = actions.results_scrolling_down,

        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },

      n = {
        ["<C-q>"] = actions.close,

        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        --["<C-u>"] = actions.results_scrolling_up,
        --["<C-d>"] = actions.results_scrolling_down,
      },
    },
  },
  pickers = {
      find_files = {
          find_command = {
            'fd',
            '--type',
            'file',
            '--type',
            'symlink',
            '--hidden',
            '--exclude',
            '.git',
          },
      prompt_title = false,
      },
  },
}

require('telescope').load_extension('fzf')

