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
      event = "VeryLazy",
      config = function()
          vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
      end
  },
  {
      "folke/zen-mode.nvim",
      event = "VeryLazy",
      opts = {
          window = {
              width = .70,
              backdrop = 1,
          }
      }
  },
  {
      'echasnovski/mini.surround',
      version = '*',
      event = "VeryLazy",
      config = function()
          require('mini.surround').setup()
      end
  },
  {
    "michaelrommel/nvim-silicon",
    cmd = "Silicon",
    main = "nvim-silicon",
    event = "VeryLazy",
    opts = {
      no_window_controls = true,
      output = function()
        return "/home/onurcakmak/code_snaps/" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
      end,
      background_image = "/home/onurcakmak/code_snaps/background.jpg",
    }
  },
}
