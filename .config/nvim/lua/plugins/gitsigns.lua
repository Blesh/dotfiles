return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local git_char = '▍'
        require('gitsigns').setup {
          signs = {
            add          = { text = git_char },
            change       = { text = git_char },
            delete       = { text = git_char },
            topdelete    = { text = git_char },
            changedelete = { text = git_char },
          },
          current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
          current_line_blame_opts = {
            virt_text = false,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 0,
            ignore_whitespace = false,
          },
          current_line_blame_formatter = '<abbrev_sha> | <author>, <author_time:%Y-%m-%d> - <summary>',
          -- keymaps
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end
            map('n', '<leader>gb', function() gs.blame_line{full=false} end)
            map('n', '<leader>gd', function() gs.diffthis('@~'..vim.fn.nr2char(vim.fn.getchar())) end)
          end
        }
        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<leader>gv", '<cmd>Gitsigns diffthis<CR>', opts)
        vim.keymap.set("n", "<leader>ph", '<cmd>Gitsigns preview_hunk<CR>', opts)
        vim.keymap.set("n", "<leader>nh", '<cmd>Gitsigns next_hunk<CR>', opts)
        vim.keymap.set("n", "<leader>sh", '<cmd>Gitsigns stage_hunk<CR>', opts)
        vim.keymap.set("n", "<leader>uh", '<cmd>Gitsigns undo_stage_hunk<CR>', opts)
    end
}
