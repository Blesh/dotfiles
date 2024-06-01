return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Schema information
       { "b0o/SchemaStore.nvim", lazy = true, version = false }
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function()
          local opts = { noremap = true, silent = true }
          local telescope = require('telescope.builtin')
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', '<leader>w', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)
          vim.keymap.set('n', 'gi', telescope.lsp_implementations, opts)
          vim.keymap.set('n', '<leader>lr', telescope.lsp_references, {})
          vim.keymap.set('n', '<leader>lic', telescope.lsp_incoming_calls, {})
          vim.keymap.set('n', '<leader>loc', telescope.lsp_outgoing_calls, {})
          -- actually seems nice, in particular if we filter manually and use the ql to navigate
          vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol, opts)
          vim.keymap.set('n', '<leader>lh', '<cmd>lua =vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', opts)
          vim.keymap.set('n', 'gt', require('telescope.builtin').lsp_type_definitions, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
        end
      })

      local servers = {
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "tpp", "cc" },
          -- https://github.com/hrsh7th/nvim-cmp/issues/999
          cmd = { "clangd", "--header-insertion-decorators=false" },
        },
        bashls = {},
        taplo = {},
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        -- https://www.lazyvim.org/extras/lang/yaml
        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
            },
          },
        },
        zls = {},
        pyright = {},
        texlab = {},
        jdtls = {},
        lua_ls = {
          on_init = function(client)
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                }
              }
            })
          end,
          settings = {
            Lua = {}
          }
        },
        rust_analyzer = {
          cargo = { allFeatures = true, },
        },
        gopls = {},
      }
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      require('mason').setup()
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
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
      doc_lines = 0,
      max_width = 100,
    },

    config = function(_, opts)
      require'lsp_signature'.setup(opts)
      vim.keymap.set({ 'i' }, '<c-s>',
        function()
          require('lsp_signature').toggle_float_win()
        end,
      { silent = true, noremap = true, desc = 'toggle signature' })
    end
  }
}

