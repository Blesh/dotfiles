-- manually set to false as otherwise meinz-scheme breaks since 0.10
vim.opt.termguicolors = false
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Get rid of auto comment on new line
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false

vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.cursorline = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 11
vim.opt.sidescrolloff = 30

-- try treesitter indentation only for now
vim.opt.autoindent = false
vim.opt.guicursor = "i:block"
-- seems unnecessary and even worse than default
-- vim.opt.spelllang = 'en_us'
vim.cmd [[set iskeyword+=-,_]]

-- try git diff adjustments from Jonhoo
-- https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.lua
-- vim.opt.diffopt:append('iwhite')
-- vim.opt.diffopt:append('algorithm:histogram')
-- vim.opt.diffopt:append('indent-heuristic')

-- Try some of the settings from kickstart https://github.com/nvim-lua/kickstart.nvim
vim.opt.mouse = 'a' -- really useful for dap-ui
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '•', nbsp = '¬' }
vim.opt.inccommand = 'split'

vim.opt.fillchars = {
  horiz = '-',
  horizdown = '-',
  horizup = '-',
  vert = '|',
  vertleft = '|',
  vertright = '|',
  verthoriz = '|',
}
