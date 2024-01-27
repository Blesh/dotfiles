return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup()
            require("lspconfig").clangd.setup{
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "tpp", "cc" },
                -- https://github.com/hrsh7th/nvim-cmp/issues/999
                -- cmd = { "clangd", "--header-insertion-decorators=false", "--clang-tidy" },
                cmd = { "clangd", "--header-insertion-decorators=false" },
            }

            --require("lspconfig").ruff_lsp.setup{}
            require("lspconfig").pyright.setup{}
            require("lspconfig").texlab.setup{}

            require("lspconfig").lua_ls.setup{
              settings = {
                Lua = {
                    diagnostics = {
                      -- Get the language server to recognize some global variables
                      globals = {'vim', 'bold', 'underline'},
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = { enable = false, },
                    -- avoid luv prompt https://github.com/LuaLS/lua-language-server/issues/783  
                    workspace = { checkThirdParty = false, },
                },
              },
            }

            require("lspconfig").rust_analyzer.setup{}
            require("lspconfig").gopls.setup{}

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
              vim.lsp.handlers.hover, {
                -- Use a sharp border with `FloatBorder` highlights
                border = "single",
              }
            )

            -- LSP
            local opts = { noremap = true, silent = true }

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>w', vim.lsp.buf.hover, opts)
            -- vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
        end
    }
}

