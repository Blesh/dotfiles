local function root_label(path)
    path = path:gsub(os.getenv("HOME"), ' ') .. '/'
    local path_len = path:len()
    local win_nr = require('nvim-tree.view').get_winnr()
    print(win_nr)
    local win_width = vim.fn.winwidth(win_nr)
    if path_len > (win_width - 2) then
        local max_str = path:sub(path_len - win_width + 5)
        local pos = max_str:find '/'
        if pos then
            return '󰉒 ' .. max_str:sub(pos)
        else
            return '󰉒 ' .. max_str
        end
    end
    return path
end

local api = require("nvim-tree.api")
    api.events.subscribe(api.events.Event.FileCreated, function(file)
    vim.cmd("edit " .. file.fname)
end)

return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local opts = {
          sort_by = "name",
          hijack_cursor = true,
          view = {
            width = { min = 35, max = 41, padding = 0 },
            number = false,
            cursorline = false,
            signcolumn = 'no',
          },
          renderer = {
            root_folder_label = root_label,
            indent_markers = {
              enable = true,
              inline_arrows = false,
              icons = { corner = '╰' },
            },
            icons = {
              git_placement = "after",
              show = { folder_arrow = false },
              glyphs = {
                symlink = '󰉒 ',
                default = '󰈔 ',
                folder = {
                  arrow_closed = '',
                  arrow_open = '',
                  default = ' ',
                  open = ' ',
                  empty = ' ',
                  empty_open = ' ',
                  symlink = '󰉒 ',
                  symlink_open = '󰉒 ',
                },
                git = {
                  deleted = '',
                  unstaged = '',
                  untracked = '',
                  staged = '',
                  unmerged = '',
                },
              },
            },
          },
          diagnostics = {
            enable = true,
            icons = {
              error = ' ',
              warning = ' ',
              info = ' ',
              hint = '󱤅 ',
            },
          },
        }
        require'nvim-tree'.setup(opts)
        -- NVIMTREE
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>",{ noremap = true, silent = true })
    end,
}
