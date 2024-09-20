return {
  {
    'mfussenegger/nvim-dap',

    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'
      local widgets = require 'dap.ui.widgets'
      local dapy = require 'dap-python'
      dapy.setup 'python3'
      vim.keymap.set('n', '<Leader>dt', dapy.test_method, { desc = 'DAP: test method' })

      vim.keymap.set('n', '<localleader>dd', function()
        dap.continue()
        ui.toggle {}
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false) -- Spaces buffers evenly
      end, { desc = 'DAP: Start debugging session' })

      -- Set breakpoints, get variable values, step into/out of functions, etc.
      vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = 'DAP: continue' })
      vim.keymap.set('n', '<localleader>dl', widgets.hover, { desc = 'DAP: Hover' })
      vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = 'DAP: toggle breakpoint' })
      vim.keymap.set('n', '<localleader>dn', dap.step_over, { desc = 'DAP: step over' })
      vim.keymap.set('n', '<localleader>di', dap.step_into, { desc = 'DAP: step into' })
      vim.keymap.set('n', '<localleader>do', dap.step_out, { desc = 'DAP: step out' })
      vim.keymap.set('n', '<localleader>dC', function()
        dap.clear_breakpoints()
        require('fidget').notify('Breakpoints cleared', 'warn')
      end, { desc = 'DAP: Clear Breakpoints' })

      -- Close debugger and clear breakpoints
      vim.keymap.set('n', '<localleader>de', function()
        dap.clear_breakpoints()
        ui.toggle {}
        dap.terminate()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false)
        require('fidget').notify('Debugger session ended', 'warn')
      end, { desc = 'DAP: End debug session' })
      vim.fn.sign_define('DapBreakpoint', { text = '🐞' })
      -- vim.keymap.set('n', '<Leader>B', dap.set_breakpoint, { desc = 'DAP: set breakpoint' })
      -- vim.keymap.set('n', '<Leader>lp', function()
      --   dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      -- end, { desc = 'DAP: log point' })
      -- vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = 'DAP: open REPL' })
      -- vim.keymap.set('n', '<Leader>dl', function()
      --   dap.run_last()
      -- end, { desc = 'DAP: run last' })
      -- vim.keymap.set({ 'n', 'v' }, '<Leader>dh', widgets.hover, { desc = 'DAP: widgets hover' })
      -- vim.keymap.set({ 'n', 'v' }, '<Leader>dp', widgets.preview, { desc = 'DAP: widgets preview' })
      -- vim.keymap.set('n', '<Leader>df', function()
      --   widgets.centered_float(widgets.frames)
      -- end, { desc = 'DAP: frames' })
      -- vim.keymap.set('n', '<Leader>dsc', function()
      --   widgets.centered_float(widgets.scopes)
      -- end, { desc = 'DAP: scopes' })
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
  },
  {
    'leoluz/nvim-dap-go',
    dependencies = { 'mfussenegger/nvim-dap' },
    opts = {
      dap_configurations = {
        {
          type = 'go',
          name = 'Attach remote',
          mode = 'remote',
          request = 'attach',
          connect = {
            host = '127.0.0.1',
            port = '43000',
          },
        },
      },
      delve = {
        port = '43000',
      },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    opts = {
      icons = { expanded = '▾', collapsed = '▸' },
      mappings = {
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      expand_lines = vim.fn.has 'nvim-0.7',
      layouts = {
        {
          elements = {
            'scopes',
          },
          size = 0.3,
          position = 'right',
        },
        {
          elements = {
            'repl',
            'breakpoints',
          },
          size = 0.3,
          position = 'bottom',
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,
      },
    },
  },
}
