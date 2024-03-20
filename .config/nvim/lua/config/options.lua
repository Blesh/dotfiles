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
-- fill tab space with spaces
vim.opt.expandtab = true
vim.opt.tabstop = 4
-- how many blanks when we use '>' or '<'
vim.opt.shiftwidth = 4

-- Not sure why I added this
-- vim.opt.writebackup = false
vim.opt.cursorline = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 11
vim.opt.sidescrolloff = 30


-- try treesitter indentation only for now
vim.opt.autoindent = false
-- vim.opt.smartindent = true
vim.opt.guicursor = "i:block"
-- seems unnecessary and even worse than default
-- vim.opt.spelllang = 'en_us'

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

-- try git diff adjustments from Jonhoo 
-- https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.lua
vim.opt.diffopt:append('iwhite')
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')

-- Try some of the settings from kickstart
-- https://github.com/nvim-lua/kickstart.nvim
vim.opt.showmode = false
-- really useful for dap-ui
vim.opt.mouse = 'a'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '•', nbsp = '¬' }
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
