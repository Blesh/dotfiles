return {
    dir = "/Users/meinz/mine/meinz-scheme.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('meinz-scheme').setup()
      vim.cmd([[colorscheme meinz-scheme]])
    end,
}
