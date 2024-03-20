return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            --scope_incremental = '<c-s>',
            node_decremental = '<c-s>',
          },
        },
        textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                ['[m'] = '@function.outer',
              },
              goto_previous_start = {
                [']m'] = '@function.outer',
              },
            },
        },
        -- List of parsers to ignore installing (for "all")
        ignore_install = { "" },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = { "" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      }
  end
}

