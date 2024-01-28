-- :help options

vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false

vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.writebackup = false
vim.opt.cursorline = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 11
vim.opt.sidescrolloff = 7


vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.guicursor = "i:block"
vim.opt.spelllang = 'en_us'

vim.opt.fillchars = {
    horiz = '-',
    horizdown = '-',
    horizup = '-',
    vert = '|',
    vertleft = '|',
    vertright = '|',
    verthoriz = '|',
}

vim.cmd [[set iskeyword+=-,_]]
