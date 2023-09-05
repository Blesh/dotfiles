local dap = require('dap')

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/local/Cellar/llvm/16.0.4/bin/lldb-vscode';
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'cpp_debugger',
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

dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp

local sign = vim.fn.sign_define

sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
