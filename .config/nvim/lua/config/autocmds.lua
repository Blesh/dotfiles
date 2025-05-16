vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.tpp',
  command = "set filetype cpp"
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.txt', '*.tex', '*.md' },
  callback = function(ev)
    vim.opt_local.textwidth = 90

    vim.opt_local.wrap = true
    vim.opt_local.formatoptions:append('t')
    vim.opt_local.colorcolumn = '91'

    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.spell = true
  end
})

local g = vim.api.nvim_create_augroup("user/keep_yank_position", { clear = true })

-- https://github.com/neovim/neovim/issues/12374
vim.api.nvim_create_autocmd("ModeChanged", {
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

vim.api.nvim_create_autocmd("ModeChanged", {
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*qf*',
  command = "nnoremap <buffer> q :cclose<CR>"
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  command = "nnoremap <buffer> q :q<CR>"
})

-- TODO Disable Semantig Highlighting or not
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client then
--       client.server_capabilities.semanticTokensProvider = nil
--     end
--     -- client.server_capabilities.semanticTokensProvider = nil
--   end,
-- });

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Change CWD to the first argument if it is a directory",
  callback = function()
    -- vim.v.argv is a list of command line arguments passed to Neovim
    if vim.v.argv and #vim.v.argv > 2 then
      -- [1]=nvim, [2]=--embed, [3]=directory
      local third_arg = vim.v.argv[3]
      -- vim.fn.isdirectory() resolves the path relative to the CWD
      if vim.fn.isdirectory(third_arg) == 1 then
        -- vim.fn.fnamemodify(path, modifiers) with ":p" gives the full absolute path.
        local abs_path = vim.fn.fnamemodify(third_arg, ":p")
        if abs_path and abs_path ~= "" then
          -- vim.fn.chdir() is a direct way to change directory in Lua.
          vim.fn.chdir(abs_path)
        end
      end
    end
  end,
  once = true
})
