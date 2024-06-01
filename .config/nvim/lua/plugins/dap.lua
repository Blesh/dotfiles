local sign = vim.fn.sign_define
sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
sign('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })

return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require('dap')
      local ui = require "dapui"

      ----------- Python Config -----------

      -- see https://github.com/mfussenegger/nvim-dap-python/blob/master/lua/dap-python.lua
      local function python_interpreter()
        local venv_path = os.getenv('VIRTUAL_ENV')
        if venv_path then
          return venv_path .. '/bin/python'
        end
        return os.getenv('HOME') .. '/.pyenv/shims/python'
      end

      local enrich_config = function(config, on_config)
        if not config.pythonPath and not config.python then
          config.pythonPath = python_interpreter()
        end
        on_config(config)
      end

      dap.adapters.python = function(cb, _)
        cb({
          type = 'executable',
          command = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python',
          args = { '-m', 'debugpy.adapter' },
          enrich_config = enrich_config;
          options = {
            source_filetype = 'python',
          },
        })
      end

      dap.configurations.python = {
        {
          name = 'debugpy: launch module';
          type = 'python';
          request = 'launch';
          program = '${file}',
          console = 'integratedTerminal',
          pythonPath = python_interpreter,
        },
        {
          name = 'debugpy: launch package',
          type = 'python',
          request = 'launch',
          program = function()
              return vim.fn.input('Package name: ', vim.fn.getcwd() .. '/.venv/bin/', 'file')
            end,
          cwd = '${workspaceFolder}',
          args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, " +")
          end,
          console = 'integratedTerminal',
          pythonPath = python_interpreter,
        },
        {
          name = 'debugpy: launch pytest',
          type = 'python',
          request = 'launch',
          module = 'pytest',
          args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, " +")
          end,
        },
      }
      require("dap-go").setup()


      local enrich_config_lldb = function(config, on_config)
        on_config(config)
      end
      -- https://github.com/llvm/llvm-project/tree/main/lldb/tools/lldb-dap#configuration
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/lib/llvm-18/bin/lldb-dap';
        name = 'lldb',
        enrich_config = enrich_config_lldb;
      }

      -- NOTE do not foget to compile with -g for debug symbols
      -- https://code.visualstudio.com/docs/cpp/launch-json-reference
      dap.configurations.cpp = {
        {
          name = 'lldb: launch binary',
          type = 'lldb',
          request = 'launch',
          program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
        },
        {
          name = 'lldb: attach process',
          type = 'lldb',
          request = 'attach',
          pid = require('dap.utils').pick_process,
        },
        {
          name = 'lldb: launch binary args',
          type = 'lldb',
          request = 'launch',
          program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          args = function()
            local args_string = vim.fn.input('args: ')
            return vim.split(args_string, " +")
          end,
        },
        {
          name = 'lldb: launch rust',
          type = 'lldb',
          request = 'launch',
          program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          showDisassembly = "never",
          cwd = '${workspaceFolder}',
          args = function()
            local test_function = vim.fn.input('args: ')
            return { 'test', test_function }
          end,
        },
        -- TODO Something for coredump file?
      }

      -- NOTE cargo build puts the binary with debug symbols under target/debug/build
      dap.configurations.rust = dap.configurations.cpp
      dap.configurations.c = dap.configurations.cpp

      -- DAP
      vim.api.nvim_create_user_command('Debug', function() dap.continue({ new = true }) end, { nargs = 0 })
      vim.api.nvim_create_user_command('DebugRestart', function() dap.restart() end, { nargs = 0 })
      vim.keymap.set('n', '<leader>dc', dap.run_to_cursor)
      vim.keymap.set('n', '<leader>dbr', dap.clear_breakpoints)
      vim.keymap.set('n', '<leader>dsb', function() dap.list_breakpoints(true) end)
      vim.keymap.set('n', '<leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
      vim.keymap.set('n', '<C-b>', dap.toggle_breakpoint)
      vim.keymap.set('n', '<Right>', dap.step_into)
      vim.keymap.set('n', '<Down>', dap.step_over)
      vim.keymap.set('n', '<Left>', dap.step_out)
      vim.keymap.set('n', '<Up>', dap.restart_frame)
      vim.keymap.set('n', '<leader>dt', dap.terminate)
      vim.keymap.set('n', '<leader>dbc', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))  end)

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

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end
  },
  {
    "ldelossa/nvim-dap-projects",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require('nvim-dap-projects').search_project_config()
    end
  }
}
