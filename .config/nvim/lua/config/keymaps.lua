local opts = { noremap = true, silent = true }

-- Leader
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })  -- do nothing in (most) modes, where do I have this from?
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--vertical split
vim.keymap.set("n", "<leader>v", ":vs<CR>", opts)

-- yank into register to avoid overwriting with deleted text at destination
vim.keymap.set("n", "<leader>y", "\"0p", opts)

-- keymap("n", "<leader>;", ":buffers<CR>", opts)

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

-- Resize
vim.keymap.set("n", "<C-w>j", ":resize +4<CR>", opts)
vim.keymap.set("n", "<C-w>k", ":resize -4<CR>", opts)
vim.keymap.set("n", "<C-w>h", ":resize -4<CR>", opts)
vim.keymap.set("n", "<C-w>l", ":resize +4<CR>", opts)

-- ESC
vim.keymap.set("i", "jj", "<Esc>", opts)

-- Indent in visual mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "q", "<Esc>", opts)

-- New tmux session

vim.keymap.set("n", "<C-f>", ":silent !tmux neww primux_sessionizer<CR>", opts)

-- Yank position
-- :vmap y ygv<Esc>
vim.keymap.set("v", "y", "ygv<Esc>", opts)



-- FUGITIVE and GITSIGNS

--vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- merge conflict take left and right
--vim.keymap.set("n", "<leader>gh", "<cmd>diffget //2<CR>")
--vim.keymap.set("n", "<leader>gl", "<cmd>diffget //3<CR>")
