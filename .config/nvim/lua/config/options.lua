-- TODO move this somehwere else
-- https://neovim.io/doc/user/lua.html#lua-stdlib
-- The Nvim Lua "standard library" (stdlib) is the vim module, which exposes various functions and sub-modules.
-- It is always loaded, thus require("vim") is unnecessary. We can execute `lua vim.print(vim)` to see the module properties
-- TODO nicer pager https://github.com/neovim/neovim/issues/5054#issuecomment-2848624986
-- We can then use `:help vim.<what_we_care_about>` to get more information about the module, it's properties, etc.

-- `vim.opt` exists for conveniently interacting with list and map-stule options from lua, while `vim.o` allows access to
-- vim options which while behaving like Vimscript `:set`.


-- manually set to false as otherwise meinz-scheme breaks since 0.10
vim.opt.termguicolors = true
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus" -- need wl-clipboard when using wayland
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
-- Not specifying any highlight groups results the TUI to use
-- host-terminal default cursor colors, typically inverted bg and fg
vim.opt.guicursor = "i:block"
-- seems unnecessary and even worse than default
vim.cmd [[set iskeyword+=-,_]]

-- Try some of the settings from kickstart https://github.com/nvim-lua/kickstart.nvim
vim.opt.mouse = 'a' -- really useful for dap-ui
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '•', nbsp = '¬' }
vim.opt.inccommand = 'split'

vim.opt.winborder = "single" --https://github.com/neovim/neovim/pull/31074

vim.opt.fillchars = {
  horiz = '-',
  horizdown = '-',
  horizup = '-',
  vert = '|',
  vertleft = '|',
  vertright = '|',
  verthoriz = '|',
}
