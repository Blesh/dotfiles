--vim.keymap.set("n", "<c-P>",
--  "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })

local actions = require "fzf-lua.actions"
require('fzf-lua').setup {
    fzf_colors       = {
      ["fg"] = { "fg", "FzfLuaNormal" },
      ["fg+"] = { "fg", "FzfLuaNormal" },
      ["bg+"] = { "bg", "FzfLuaNormal" },
      ["bg"] = { "bg", "FzfLuaNormal" },
      ["hl"] = { "fg", "FzfLuaSearch" },
      ["hl+"] = { "fg", "FzfLuaSearch" },
      ["info"] = { "fg", "FzfLuaInfo" },
      ["prompt"] = { "fg", "FzfLuaPrompt" },
      ["marker"] = { "fg", "FzfLuaMarker" },
      ["pointer"] = { "fg", "FzfLuaPointer" },
      ["spinner"] = { "fg", "FzfLuaSpinner" },
      ["border"] = { "fg", "FzfLuaBorder" },
      ["gutter"] = { "bg", "FzfLuaGutter" },
      ["header"] = { "fg", "FzfLuaTitel" },
      ["scrollbar"] = { "fg", "FzfLuaScrollbar" },
    },
    winopts = {
      width   = 0.8,
      height  = 0.9,
      preview = {
        hidden       = "nohidden",
        vertical     = "up:75%",
        horizontal   = "right:44%",
        layout       = "flex",
        flip_columns = 120,
        title_align = "center",
        scrollbar = false,
        winopts = {
            cursorline = false,
            number = false,
        }
      },
    },
    grep = { prompt = '   '}
}
