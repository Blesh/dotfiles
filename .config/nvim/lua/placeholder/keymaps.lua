local opts = { noremap = true, silent = true }

-- Leader
vim.keymap.set("", "<Space>", "<Nop>", opts)  -- do nothing in (most) modes, where to I have this from?
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

-- telescope
vim.keymap.set("n", "<leader>p", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
vim.keymap.set("n", "<leader>s", "<cmd>Telescope live_grep<cr>", opts)

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- harpoon

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, opts)
vim.keymap.set("n", "<leader>j", ui.toggle_quick_menu, opts)

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end)
vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) end)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>l", function() vim.api.nvim_list_wins() end)

-- fzf_lua

vim.keymap.set("n", "<leader>f", "<cmd>lua require('fzf-lua').files()<CR>", {silent = true});
vim.keymap.set("n", "<leader>p", "<cmd>lua require('fzf-lua').live_grep()<CR>", {silent = true});
vim.keymap.set("n", "<leader>gl", "<cmd>lua require('fzf-lua').git_files()<CR>", {silent = true});
vim.keymap.set("n", "<leader>hi", "<cmd>lua require('fzf-lua').highlights()<CR>", {silent = true});
vim.keymap.set("n", "<leader>l", "<cmd>lua require('fzf-lua').lsp_finder()<CR>", {silent = true});
-- Use trouble instead of fzf diagnostics for now
-- vim.keymap.set("n", "<leader>sd", "<cmd>lua require('fzf-lua').diagnostics_document()<CR>", {silent = true});
--vim.keymap.set("n", "<leader>dp", "<cmd>lua require('fzf-lua').diagnostics_workspace()<CR>", {silent = true});

-- lsp

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<leader>w', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<leader>ci', vim.lsp.buf.incoming_calls, opts)
vim.keymap.set('n', '<leader>co', vim.lsp.buf.outgoing_calls, opts)
vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)
--vim.keymap.set('n', 'gR', "<cmd>TroubleToggle lsp_references<cr>", opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

-- trouble

vim.keymap.set('n', '<leader>d', '<cmd>TroubleToggle document_diagnostics<CR>', opts)
vim.keymap.set('n', '<leader>D', '<cmd>TroubleToggle workspace_diagnostics<CR>', opts)

-- dap
-- vim.keymap.set('n', '<leader>B', '<Cmd>DapToggleBreakpoint<CR>', opts)
vim.keymap.set('n', '<leader>B', function() require('dap').toggle_breakpoint() end)
-- vim.keymap.set('n', '<leader><leader>B', function() require('dap').clear_breakpoints() end)
-- vim.keymap.set('n', '<leader><leader>C', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>so', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>si', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>soo', function() require('dap').step_out() end)
-- vim.keymap.set('n', '<leader>dr', function() require('dap').repl.toggle() end)
-- vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
--vim.keymap.set({'n', 'v'}, '<leader>dh', function() require('dap.ui.widgets').hover() end)
--vim.keymap.set({'n', 'v'}, '<leader>dp', function() require('dap.ui.widgets').preview() end)
-- vim.keymap.set('n', '<leader>df', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.frames).toggle() end)
-- vim.keymap.set('n', '<leader>ds', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.scopes).togglet() end)
