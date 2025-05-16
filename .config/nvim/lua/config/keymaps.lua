local opts = { noremap = true, silent = true }

-- Leader
-- do nothing in (most) modes, where do I have this from?

-- `vim.keymap.set({mode}, {lhs}, {rhs}, {opts})` Defines a |mapping| of |keycodes| to a function or keycodes.
-- `mode (string|string[])`: mode short-name 'n', 'i', 'v', 'x',
-- `lhs (string)`: keycodes triggering rhs
-- `rhs (string|function)`: executed as a result of `lhs` in `mode`
-- `opts (table?): { -- see h map-arguments
--      buffer: <id> -- for buffer local keymaps
--      noremap: <bool> -- disalbes recursive mapping, i.e., disallow mapping of {rhs}
--      desc: <string> -- human readable description
--      callback: <string> -- lua function called in place of {rhs} (why is this useful?)
--      replace_keycodes: <bool> -- ?
--      silent <bool>: mapping will not be echoed in the command line, to get rid of messages from commands we need to add
--                  `:silent` to the command as well
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--vertical split
vim.keymap.set("n", "<leader>v", ":vs<CR>", opts)

-- yank into register to avoid overwriting with deleted text at destination
vim.keymap.set("n", "<leader>y", "\"0p", opts)

-- prev buffer
vim.keymap.set("n", "<leader><leader>", "<c-^>", opts)

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Navigation zz
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

vim.keymap.set("n", "Q", "<nop>", opts)
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-k>", "<C-W>5+")
vim.keymap.set("n", "<M-j>", "<C-W>5-")

-- ESC
vim.keymap.set("i", "jj", "<Esc>", opts)

-- Indent in visual mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "q", "<Esc>", opts)

-- New tmux session
vim.keymap.set("n", "<C-f>", ":silent !tmux neww primux_sessionizer<CR>", opts)

-- Jump to start and end of line using the home row keys
-- https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.lua
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')

-- 0.11 introduced default keybindings '[q' and ']q' https://github.com/neovim/neovim/pull/28525/files
-- 0.11 also introduce `[<Space>` and `]<Space>` to add newlines above and below the current line in normal mode

vim.keymap.set('n', '<leader>cd', ':DiffviewClose<CR>', { noremap = true, silent = true })
