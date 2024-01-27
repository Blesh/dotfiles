return {
    "nvim-lua/plenary.nvim",
    {
        --"iamcco/markdown-preview.nvim",
        --cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        --ft = { "markdown" },
        --build = function() vim.fn["mkdp#util#install"]() end,
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
          vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" }
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    }
}
