vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { noremap = true, silent = true }
    local fuzzy = require('fzf-lua')
    vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>lct', function() vim.lsp.buf.typehierarchy("subtypes") end, opts)
    vim.keymap.set('n', '<leader>lpt', function() vim.lsp.buf.typehierarchy("supertypes") end, opts)
    vim.keymap.set('n', 'gD', fuzzy.lsp_declarations, opts)
    vim.keymap.set('n', '<leader>w', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gd', fuzzy.lsp_definitions, opts)
    vim.keymap.set('n', 'gi', fuzzy.lsp_implementations, opts)
    vim.keymap.set('n', '<leader>lr', fuzzy.lsp_references, opts)
    vim.keymap.set('n', '<leader>lic', fuzzy.lsp_incoming_calls, opts)
    vim.keymap.set('n', '<leader>loc', fuzzy.lsp_outgoing_calls, opts)
    vim.keymap.set('n', '<leader>lds', fuzzy.lsp_document_symbols, opts)
    vim.keymap.set('n', '<leader>lws', fuzzy.lsp_live_workspace_symbols, opts) -- TODO look into how exactly workspace is defined
    vim.keymap.set('n', '<leader>ca', fuzzy.lsp_code_actions, opts)
    vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

    vim.keymap.set('n', 'gh', ":LspClangdSwitchSourceHeader <CR>", opts) -- TODO creat mapping only for clangd / c

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- see https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#metaModel
    -- and vim.lsp.protocol.Methods for all possible methods which are defined in the neovim project file
    -- neovim/runtime/lua/vim/lsp/protocol.lua
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      vim.api.nvim_create_autocmd('CursorMoved', {
        callback = function(_)
          vim.lsp.buf.clear_references()
          vim.lsp.buf.document_highlight()
        end
      })
    end
  end,
})

local capabilities = vim.tbl_deep_extend("force",
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

-- see for all all available options https://neovim.io/doc/user/lsp.html#vim.lsp.ClientConfig
-----------------------
------- clangd
-----------------------
vim.lsp.config('clangd', {
  capabilities = capabilities,
  -- https://github.com/hrsh7th/nvim-cmp/issues/999
  cmd = { "clangd", "--header-insertion-decorators=false" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "tpp", "cc" },
})

-----------------------
------- rust-analyzer
-----------------------
vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
  -- https://github.com/hrsh7th/nvim-cmp/issues/999
  cargo = { allFeatures = true, },
  checkOnSave = {
    command = "clippy",
  },
})

-----------------------
------- lua_ls
-----------------------
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          '${3rd}/luv/library',
          '${3rd}/busted/library',
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})


-----------------------
------- bash_ls
-----------------------
vim.lsp.config('bash_ls', {
  capabilities = capabilities,
})

-----------------------
------- jsonls
-----------------------
vim.lsp.config('jsonls', {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

-----------------------
------- yamlls
-----------------------
vim.lsp.config('yamlls', {
  capabilities = capabilities,
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
  }
})

vim.lsp.enable({
  'yamlls',
  'jsonls',
  'bash_ls',
  'lua_ls',
  'rust_analyzer',
  'clangd'
})
