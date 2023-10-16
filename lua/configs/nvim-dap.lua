return function ()
  -- INFO: Setting DAP icons
  vim.fn.sign_define('DapBreakpoint', {text='', texthl='ErrorMsg', linehl='', numhl=''})
  vim.cmd('highlight DapStoppedSign guifg=#87D285')
  vim.fn.sign_define('DapStopped', {text='', texthl='DapStoppedSign', linehl='DapStoppedSign', numhl=''})

  -- INFO: DAP keymaps
  local dap = require('dap')
  vim.keymap.set('n', '<F5>', function() vim.cmd('wa') require('dap').continue() end)
  vim.keymap.set('n', '<F10>', dap.step_over)
  vim.keymap.set('n', '<F11>', dap.step_into)
  vim.keymap.set('n', '<F12>', dap.step_out)
  vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint)
  vim.keymap.set('n', '<Leader>dl', dap.run_last)
  vim.keymap.set('n', '<Leader>ds',
    function()
      require('dap').close()
      require("dapui").close()
    end)

  -- INFO: DAPUI keymaps
  vim.keymap.set('n', '<leader>do', function() require("dapui").toggle() end)
  vim.keymap.set('n', '<leader>de', function() require("dapui").eval() end)
  vim.keymap.set('n', '<leader>dr', function() require("dapui").float_element('repl',{}) end)


  -- INFO: Custom dap configs

  -- INFO: Javascript & Typescript debugger
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "127.0.0.1",
    port = 8123,
    executable = {
      command = "js-debug-adapter",
    }
  }

  -- INFO: Load vscode launch.json
  require('dap.ext.vscode').load_launchjs(nil, {})
end
