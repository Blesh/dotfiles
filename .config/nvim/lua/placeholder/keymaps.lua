local opts = { noremap = true, silent = true }

-- Leader
vim.keymap.set("", "<Space>", "<Nop>", opts)  -- do nothing in (most) modes, where do I have this from?
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

-- NVIMTREE
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- HARPOON

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
--vim.keymap.set("n", "<leader>l", function() vim.api.nvim_list_wins() end)

-- TELESCOPE

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

vim.keymap.set('n', '<leader>f', function()
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

vim.keymap.set('n', '<leader>gf', function()
  builtin.git_files(require('telescope.themes').get_dropdown{
    previewer = false,
    prompt_title = false,
  })
end ,{})

-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
    prompt_title = false,
  })
end, {})

vim.keymap.set('n', '<leader>p', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sic', builtin.lsp_incoming_calls, {})
vim.keymap.set('n', '<leader>soc', builtin.lsp_outgoing_calls, {})
-- might no longer need trouble plugin using this
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>sgc', builtin.git_commits, {}) -- maybe?
vim.keymap.set('n', '<leader>shi', builtin.highlights, {}) -- maybe?
vim.keymap.set('n', '<leader>str', builtin.treesitter, {}) -- maybe?
vim.keymap.set('n', '<leader>sht', builtin.help_tags, {}) -- maybe?
vim.keymap.set('n', '<leader>sr', builtin.lsp_references, {}) -- maybe?
vim.keymap.set('n', '<leader>sd', builtin.lsp_definitions, {}) -- maybe?

-- LSP

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<leader>w', vim.lsp.buf.hover, opts)
-- vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)

-- TROUBLE

vim.keymap.set('n', '<leader>sd', '<cmd>TroubleToggle document_diagnostics<CR>', opts)
vim.keymap.set('n', '<leader>sD', '<cmd>TroubleToggle workspace_diagnostics<CR>', opts)

-- https://github.com/AlexvZyl/nvim/blob/main/lua/alex/keymaps/utils.lua
DAP_UI_ENABLED = false
local function dap_toggle_ui()
    require('dapui').toggle()
    DAP_UI_ENABLED = true
end
local function dap_float_scope()
    if not DAP_UI_ENABLED then return end
    require('dapui').float_element 'scopes'
end
-- DAP
vim.keymap.set('n', '<leader>Dc', function() require('dap').continue() end)
vim.keymap.set('n', '<C-b>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Right>', function() require('dap').step_into() end)
vim.keymap.set('n', '<Down>', function() require('dap').step_over() end)
vim.keymap.set('n', '<Left>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Up>', function() require('dap').restart_frame() end)
vim.keymap.set('n', '<leader>Dt', function() require('dap').terminate() end)
vim.keymap.set('n', '<leader>Ds', function() dap_float_scope() end)
vim.keymap.set('n', '<leader>Du', function() dap_toggle_ui() end)
vim.keymap.set('n', '<leader>Dbc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))  end)

-- FUGITIVE and GITSIGNS

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gv", '<cmd>Gitsigns diffthis<CR>', opts)
vim.keymap.set("n", "<leader>ph", '<cmd>Gitsigns preview_hunk<CR>', opts)
vim.keymap.set("n", "<leader>nh", '<cmd>Gitsigns next_hunk<CR>', opts)
vim.keymap.set("n", "<leader>sh", '<cmd>Gitsigns stage_hunk<CR>', opts)
vim.keymap.set("n", "<leader>uh", '<cmd>Gitsigns undo_stage_hunk<CR>', opts)

-- merge conflict take left and right
vim.keymap.set("n", "<leader>gh", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "<leader>gl", "<cmd>diffget //3<CR>")
