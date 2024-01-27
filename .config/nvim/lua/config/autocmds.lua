vim.api.nvim_exec2([[
  autocmd BufRead,BufNewFile *.tpp setfiletype cpp
]], {output = false})


-- Spell checking only for relevant files
vim.api.nvim_exec2([[
    autocmd BufRead,BufNewFile *.tex,*.md,*.MD,*.txt setlocal spell
]], {output = false})

vim.cmd [[ autocmd FileType markdown,text,tex setlocal wrap ]]

