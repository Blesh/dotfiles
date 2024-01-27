return {
    "folke/trouble.nvim",

    config = function()
        require('trouble').setup({
            icons = false,
            padding = false,
            symbols = { error = ' ', warning = ' ', information = ' ', hint = '󱤅 ', other = '󰠠 ' },
        })
        vim.keymap.set('n', '<leader>sd', '<cmd>TroubleToggle document_diagnostics<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>sD', '<cmd>TroubleToggle workspace_diagnostics<CR>', { noremap = true, silent = true })
    end,
}
