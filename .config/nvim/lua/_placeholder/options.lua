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

vim.cmd [[set iskeyword+=-,_]]
-- this should not be necessary with smartindent right?
-- vim.cmd [[inoremap {<Enter> {<Enter>}<Esc>O]] 

-- Syntax highlighting for .tpp files in cpp projects
-- nvim_exec to evaluate vim script or ex command
-- [[ ... ]] is luas way for literal strings, avoiding things like escpaing "" 
-- Do I need this even after adding .tpp to my lsp config?
vim.api.nvim_exec2([[
  autocmd BufRead,BufNewFile *.tpp setfiletype cpp
]], {output = false})


-- Spell checking only for relevant files
vim.api.nvim_exec2([[
    autocmd BufRead,BufNewFile *.tex,*.md,*.MD,*.txt setlocal spell
]], {output = false})

vim.cmd [[ autocmd FileType markdown,text,tex setlocal wrap ]]

vim.g.mkdp_markdown_css = '$HOME/github-markdown-light.css'
vim.g.mkdp_theme = 'light'
vim.g.mkdp_preview_options = {
  mkit = {},
  katex = {},
  uml = {},
  maid = {},
  disable_sync_scroll = 0,
  sync_scroll_type = 'middle',
  hide_yaml_meta = 1,
  sequence_diagrams = {},
  flowchart_diagrams = {},
  content_editable = false,
  disable_filename = true,
  toc = {}
}

