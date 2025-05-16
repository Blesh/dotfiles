return {
    -- https://lazy.folke.io/spec/examples
    dir = os.getenv("HOME") .. "/mine/meinz-scheme.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd([[colorscheme meinz-scheme]])
    end,
}
