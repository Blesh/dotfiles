local dap = require('dap')

dap.adapters.lldb = {
    name = 'lldb',
    type = 'executable',
	command = '/usr/local/Cellar/llvm/16.0.4/bin/lldb-vscode'
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

require('dap-go').setup()
-- python location with debugpy installed
require('dap-python').setup('/usr/local/bin/python3')


local sign = vim.fn.sign_define
sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })

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
                    id = 'stacks',
                    size = 0.30,
                },
                {
                    id = 'watches',
                    size = 0.40,
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

