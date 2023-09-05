require('mason').setup()
require('mason-lspconfig').setup()

require("lspconfig").clangd.setup{
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "tpp", "cc" },
    -- https://github.com/hrsh7th/nvim-cmp/issues/999
    -- cmd = { "clangd", "--header-insertion-decorators=false", "--clang-tidy" },
    cmd = { "clangd", "--header-insertion-decorators=false" },
}

require("lspconfig").ruff_lsp.setup{}
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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    -- Use a sharp border with `FloatBorder` highlights
    border = "single",
  }
)
