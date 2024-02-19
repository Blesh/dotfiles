return {
    "nvim-lua/plenary.nvim",
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_markdown_css = '$HOME/github-markdown-light.css'
            vim.g.mkdp_theme = 'light'
            vim.g.mkdp_preview_options = {
              mkit = {},
              katex = {},
              uml = {},
              maid = {},
              disable_sync_scroll = 1,
              sync_scroll_type = 'middle',
              hide_yaml_meta = 1,
              sequence_diagrams = {},
              flowchart_diagrams = {},
              content_editable = false,
              disable_filename = true,
              toc = {}
            }
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
