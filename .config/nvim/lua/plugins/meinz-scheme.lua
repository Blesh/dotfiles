return {
    dir = os.getenv("HOME") .. "/mine/meinz-scheme.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme "meinz-scheme"
    end,
}
