return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(event)
                    local opts = { noremap = true, silent = true }
                    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, opts)
                    vim.keymap.set('n', '<leader>w', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gt', require('telescope.builtin').lsp_type_definitions, opts)
                    -- vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
                    -- vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
                    vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
                    vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
                end
            })
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            local servers = {
                clangd = {
                    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "tpp", "cc" },
                    -- https://github.com/hrsh7th/nvim-cmp/issues/999
                    -- cmd = { "clangd", "--header-insertion-decorators=false", "--clang-tidy" },
                    cmd = { "clangd", "--header-insertion-decorators=false" },
                },
                pyright = {},
                texlab = {},
                jdtls = {},
                lua_ls = {
                    diagnostics = {
                      -- Get the language server to recognize some global variables
                      globals = {'vim', 'bold', 'underline'},
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = { enable = false, },
                    -- avoid luv prompt https://github.com/LuaLS/lua-language-server/issues/783  
                    workspace = { checkThirdParty = false, },
                },
                rust_analyze = {},
                gopls = {},
            }
            require('mason').setup()
            require('mason-lspconfig').setup {
                handlers = {
                  function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                  end,
                },
            }
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
              vim.lsp.handlers.hover, {
                -- Use a sharp border with `FloatBorder` highlights
                border = "single",
             })
        end
    },
    {
          "scalameta/nvim-metals",
          dependencies = {
            "nvim-lua/plenary.nvim",
          },
          ft = { "scala", "sbt", "java" },
          opts = function()
            local metals_config = require("metals").bare_config()
            metals_config.init_options.statusBarProvider = "off"
          end,
          config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
              pattern = self.ft,
              callback = function()
                require("metals").initialize_or_attach(metals_config)
              end,
              group = nvim_metals_group,
            })
          end
    },
    {
      "ray-x/lsp_signature.nvim",
      event = "VeryLazy",
      opts = {
        hint_enable = false,
        toggle_key = '<C-n>',
        doc_lines = 0,
        max_width = 100,
      },
      config = function(_, opts) require'lsp_signature'.setup(opts) end
    }
}

