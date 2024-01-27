-- Show git status.
-- see https://github.com/AlexvZyl/nvim/blob/main/lua/alex/ui/lualine.lua

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed } end
end
local function parent_folder()
    local current_buffer = vim.api.nvim_get_current_buf()
    local current_file = vim.api.nvim_buf_get_name(current_buffer)
    local parent = vim.fn.fnamemodify(current_file, ':h:t')
    if parent == '.' then return '' end
    return parent .. '/'
end

-- Get the buffer's filename.
local function get_current_filename()
    local bufname = vim.api.nvim_buf_get_name(0)
    return bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or ''
end


-- Get the current buffer's type.
local function get_current_buftype() return vim.api.nvim_buf_get_option(0, 'buftype') end

-- Get the current buffer's filetype.
local function get_current_filetype() return vim.api.nvim_buf_get_option(0, 'filetype') end

local function get_native_lsp()
    local buf_ft = get_current_filetype()
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return '' end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= 'copilot' then return client.name end
    end
    return ''
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        'nvim-telescope/telescope.nvim',
        "nvim-tree/nvim-tree.lua",
    },
    config = function()

        -- Display the difference in commits between local and head.
        local Job = require 'plenary.job'
        local function get_git_compare()
            -- Get the path of the current directory.
            local curr_dir = vim.api.nvim_buf_get_name(0):match('(.*' .. '/' .. ')')

            -- Run job to get git.
            local result = Job:new({
                command = 'git',
                cwd = curr_dir,
                args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },
            })
                :sync(100)[1]

            -- Process the result.
            if type(result) ~= 'string' then return '' end
            local ok, ahead, behind = pcall(string.match, result, '(%d+)%s*(%d+)')
            if not ok then return '' end

            -- No file, so no git.
            if get_current_buftype() == 'nofile' then return '' end
            local string = ''
            if behind ~= '0' then string = string .. '󱦳' .. behind end
            if ahead ~= '0' then string = string .. '󱦲' .. ahead end
            return string
        end

        -- Required to properly set the colors.
        local c = require 'meinz-scheme.colors'


        -- Telescope Config
        local function telescope_text() return 'Telescope' end

        local telescope = {
            sections = {
                lualine_a = {
                    {
                        'mode',
                    },
                },
                lualine_b = {},
                lualine_c = {
                    {
                        telescope_text,
                        color = { fg = c.white_01 },
                        icon = { '  ', color = { fg = c.white_01 } },
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {
                    {
                        'location',
                        icon = { '', align = 'left', color = { fg = c.white_01 } },
                    },
                    {
                        'progress',
                        icon = { '', align = 'left', color = { fg = c.white_01 } },
                    },
                },
            },
            filetypes = { 'TelescopePrompt' },
        }

        -- nvim-tree

        local function get_short_cwd() return vim.fn.fnamemodify(vim.fn.getcwd(), ':~') end

        local tree = {
            sections = {
                lualine_a = { { 'mode', }, },
                lualine_b = {},
                lualine_c = {
                    {
                        get_short_cwd,
                        padding = 0,
                        icon = { '   ', color = { fg = c.white_01 } },
                        color = { fg = c.white_01 },
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {
                    {
                        'location',
                        icon = { '', align = 'left', color = { fg = c.white_01 } },
                    },
                    {
                        'progress',
                        icon = { '', align = 'left', color = { fg = c.white_01 } },
                    },
                },
            },
            filetypes = { 'NvimTree' },
        }



        require('lualine').setup {
            sections = {
                 lualine_a = {'mode'},
                 lualine_b = {},
                 lualine_c = {
                    {
                        parent_folder,
                        color = { fg = c.white_01 },
                        icon = { '   ', color = { fg = c.white_01 } },
                        separator = '',
                        padding = 0,
                    },
                    {
                        get_current_filename,
                        color = { fg = c.white_01 },
                        separator = ' ',
                        padding = 0,
                    },
                    {
                        'branch',
                        color = { fg = c.white_01 },
                        icon = { '   ', color = { fg = c.white_01 } },
                        separator = ' ',
                        padding = 0,
                    },
                    {
                        get_git_compare,
                        separator = ' ',
                        padding = 0,
                        color = { fg = c.white_01 },
                    },
                    {
                        'diff',
                        padding = 0,
                        colored = true,
                        color = { ctermfg = 1 },
                        icon = { ' ', color = { ctermfg = 0 } },
                        source = diff_source, 
                        symbols = { added = ' ', modified = ' ', removed = ' ' },
                        diff_color = {
                            added = { fg = c.green_02 },
                            modified = { fg = c.cyan_02 },
                            removed = { fg =  c.red_02 },
                        },
                    },
                 },
                 lualine_x = {
                 {
                     'diagnostics',
                     sources = { 'nvim_diagnostic' },
                     symbols = { error = ' ', warn = ' ', info = ' ', hint = '󱤅 ', other = '󰠠 ' },
                     diagnostics_color = {
                         error = { fg = c.red_02 },
                         warn = { fg = c.yellow_02 },
                         info = { fg = c.yellow_01 },
                         hint = { fg = c.green_01 },
                     },
                     colored = true,
                     padding = 1,
                 },
                 {
                     get_native_lsp,
                     padding = 2,
                     separator = ' ',
                     color = { fg = c.white_02 },
                     icon = { ' ', color = { fg = c.white_01 } },
                 },
                },
                lualine_y = {},
                lualine_z = {
                    {
                        'location',
                        icon = { '', align = 'left', color = { fg = c.white_01 } },
                    },
                    {
                        'progress',
                        icon = { '', align = 'left', color = { fg = c.white_01 } },
                    },
                },
                -- lualine_z = {'location'},
            },
            options = {
                theme = 'meinz-scheme',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                globalstatus = true,
            },
            extensions = {
                telescope,
                ['nvim-tree'] = tree,
            },
        }
    end
}
