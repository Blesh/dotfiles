return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    tag = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
              require("telescope").load_extension("fzf")
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
    },

    config = function()
        local actions = require "telescope.actions"
        require('telescope').setup{
          defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            path_display =  { "truncate" },
            prompt_prefix = '   ',
            selection_caret = '  ',
            layout_strategy = "vertical",
            mappings = {
              n = {
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
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
                    '--exclude',
                    '.node_modules',
                    '--exclude',
                    '.venv',
                    '--exclude',
                    'cmake-build-debug',
                    '--exclude',
                    'cmake-build-release',
                    "--strip-cwd-prefix",
                  },
              prompt_title = false,
              },
          },
          extensions = {
              ['ui-select'] = {
                require('telescope.themes').get_dropdown(),
              },
          },
        }
        -- Enable Telescope extensions if they are installed
        -- I never did this before, does that mean I never used the fzf extension?
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require('telescope.builtin')

        -- change config
        vim.keymap.set('n', '<leader>cc', function()
          builtin.find_files(require('telescope.themes').get_dropdown{
            cwd = "~/dotfiles/.config/nvim",
            layout_strategy = "center",
            layout_config = {
              width = 0.5,
              height = 0.4,
              prompt_position = "top"
            },
            previewer = false,
            prompt_title = false,
          })
        end, {})

        vim.keymap.set('n', '<leader>sf', function()
          builtin.find_files(require('telescope.themes').get_dropdown{
            layout_strategy = "center",
            layout_config = {
              width = 0.5,
              height = 0.4,
              prompt_position = "top"
            },
            previewer = false,
            prompt_title = false,
          })
        end, {})

        -- Don't think I've used this is in the last weeks once
        -- vim.keymap.set('n', '<leader>gf', function()
        --   builtin.git_files(require('telescope.themes').get_dropdown{
        --     previewer = false,
        --     prompt_title = false,
        --   })
        -- end ,{})

        -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
        vim.keymap.set('n', '<leader>/', function()
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            previewer = false,
            prompt_title = false,
          })
        end, {})
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, {})

        vim.keymap.set('n', '<leader>sp', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>sic', builtin.lsp_incoming_calls, {})
        vim.keymap.set('n', '<leader>soc', builtin.lsp_outgoing_calls, {})
        -- might no longer need trouble plugin using this
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {})
        vim.keymap.set('n', '<leader>sgc', builtin.git_commits, {}) -- maybe?
        vim.keymap.set('n', '<leader>shi', builtin.highlights, {}) -- maybe?
        vim.keymap.set('n', '<leader>str', builtin.treesitter, {}) -- maybe?
        vim.keymap.set('n', '<leader>sht', builtin.help_tags, {}) -- maybe?
        vim.keymap.set('n', '<leader>sr', builtin.lsp_references, {}) -- maybe?
    end
}

