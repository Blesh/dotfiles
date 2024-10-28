vim.api.nvim_exec2([[
  autocmd BufRead,BufNewFile *.tpp setfiletype cpp
]], {output = false})


-- Spell checking only for relevant files
vim.api.nvim_exec2([[
    autocmd BufRead,BufNewFile *.tex,*.txt setlocal spell
]], {output = false})

vim.cmd [[ autocmd FileType markdown,text,tex setlocal wrap ]]

local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

local g = augroup("user/keep_yank_position", { clear = true })

-- https://github.com/neovim/neovim/issues/12374
autocmd("ModeChanged", {
  pattern = { "n:no", "no:n" },
  group = g,
  callback = function(ev)
    if vim.v.operator == "y" then
      if ev.match == "n:no" then
        vim.b.user_yank_last_pos = vim.fn.getpos(".")
      else
        if vim.b.user_yank_last_pos then
          vim.fn.setpos(".", vim.b.user_yank_last_pos)
          vim.b.user_yank_last_pos = nil
        end
      end
    end
  end,
})

autocmd("ModeChanged", {
  pattern = {
    "V:n",
    "n:V",
    "v:n",
    "n:v",
  },
  group = g,
    callback = function(ev)
      local match = ev.match
      if vim.tbl_contains({ "n:V", "n:v" }, match) then
        vim.b.user_yank_last_pos = vim.api.nvim_win_get_cursor(0)
      else
        if vim.v.operator == "y" then
          local last_pos = vim.b.user_yank_last_pos
          if last_pos then
            vim.api.nvim_win_set_cursor(0, last_pos)
          end
        end
      vim.b.user_yank_last_pos = nil
    end
  end,
})

-- quickfix q

vim.cmd([[autocmd FileType qf nnoremap <buffer> q :cclose<CR>]])
