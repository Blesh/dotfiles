-- TODO refactor
return {
  {
    -- https://github.com/tjdevries/config.nvim
    "kndndrj/nvim-dbee",
    dependencies = { "MunifTanjim/nui.nvim" },
    -- event = "VeryLazy",
    lazy = true,
    build = function()
      require("dbee").install()
    end,
    config = function()
      local source = require "dbee.sources"
      require("dbee").setup {
        sources = {
          source.MemorySource:new({
            ---@diagnostic disable-next-line: missing-fields
            {
              type = "postgres",
              name = "riot",
              url = "postgresql://postgres@knx-cl-291:5432/riot?sslmode=disable",
            },
          }, "riot"),
        },
      }
      vim.keymap.set("n", "<space>od", function()
        require("dbee").toggle()
      end)

      ---@diagnostic disable-next-line: param-type-mismatch
      local base = vim.fs.joinpath(vim.fn.stdpath "state", "dbee", "notes")
      local pattern = string.format("%s/.*", base)
      vim.filetype.add {
        extension = {
          sql = function(path, _)
            if path:match(pattern) then
              return "sql.dbee"
            end

            return "sql"
          end,
        },

        pattern = {
          [pattern] = "sql.dbee",
        },
      }
    end,
  },
}
