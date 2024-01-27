return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require('dap')


            local sign = vim.fn.sign_define
            sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
            sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
            sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })

            dap.adapters.lldb = {
                type = 'executable',
                command = '/usr/local/Cellar/llvm/16.0.4/bin/lldb-vscode';
                name = 'lldb'
            }

            -- NOTE do not foget to compile with -g for debug symbols
            dap.configurations.cpp = {
                {
                    name = 'lldb_debugger',
                    type = 'lldb',
                    request = 'launch', -- debug adapter should start dubger
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}', -- current working directory of Neovim
                    stopOnEntry = false,
                    -- args = {'../datasets/dataset_dtu/graph_2007_000033_1.txt.bbk', 'hpf'},
                },
            }

            -- NOTE cargo build puts the binary with debug symbols under target/debug/build
            dap.configurations.rust = dap.configurations.cpp
            dap.configurations.c = dap.configurations.cpp

            -- DAP
            vim.keymap.set('n', '<leader>Dc', function() require('dap').continue() end)
            vim.keymap.set('n', '<C-b>', function() require('dap').toggle_breakpoint() end)
            vim.keymap.set('n', '<Right>', function() require('dap').step_into() end)
            vim.keymap.set('n', '<Down>', function() require('dap').step_over() end)
            vim.keymap.set('n', '<Left>', function() require('dap').step_out() end)
            vim.keymap.set('n', '<Up>', function() require('dap').restart_frame() end)
            vim.keymap.set('n', '<leader>Dt', function() require('dap').terminate() end)
            vim.keymap.set('n', '<leader>Dbc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))  end)
        end
    },
    "leoluz/nvim-dap-go",
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require('dap-python').setup('/usr/local/bin/python3')
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()

            require('dapui').setup({
                    layouts = {
                    -- Vertical bar.
                    {
                        elements = {
                            {
                                id = 'scopes',
                                size = 0.30,
                            },
                            {
                                id = 'watches',
                                size = 0.40,
                            },
                            {
                                id = 'stacks',
                                size = 0.30,
                            },
                        },
                        size = 0.3,
                        position = 'left',
                    },
                    -- Horizontal bar.
                    {
                        elements = {
                            'repl',
                        },
                        size = 0.2,
                        position = 'bottom',
                    },
                },
            })
            -- https://github.com/AlexvZyl/nvim/blob/main/lua/alex/keymaps/utils.lua
            DAP_UI_ENABLED = false
            local function dap_toggle_ui()
                require('dapui').toggle()
                DAP_UI_ENABLED = true
            end
            local function dap_float_scope()
                if not DAP_UI_ENABLED then return end
                require('dapui').float_element 'scopes'
            end
            vim.keymap.set('n', '<leader>Ds', function() dap_float_scope() end)
            vim.keymap.set('n', '<leader>Du', function() dap_toggle_ui() end)
        end,
    }
}
