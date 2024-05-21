return {
    dir = os.getenv("HOME") .. "/mine/meinz-scheme.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require('meinz-scheme').setup()
      vim.cmd([[colorscheme meinz-scheme]])
    end,
}
