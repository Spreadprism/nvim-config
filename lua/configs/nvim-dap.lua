return function ()
  -- Set breakpoint
  vim.fn.sign_define('DapBreakpoint', {text='', texthl='ErrorMsg', linehl='', numhl=''})
  vim.cmd('highlight DapStoppedSign guifg=#87D285')
  vim.fn.sign_define('DapStopped', {text='', texthl='DapStoppedSign', linehl='', numhl=''})

  vim.keymap.set('n', '<F5>', function() vim.cmd('wa') require('dap').continue() end)
  vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
  vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
  vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
  vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
  vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end)
  vim.keymap.set('n', '<Leader>dr', function() require('dap').run_last() end)
  vim.keymap.set('n', '<Leader>ds',
    function()
      require('dap').close()
      require("dapui").close()
    end)

  vim.keymap.set('n', '<leader>do', function() require("dapui").toggle() end)
  vim.keymap.set('n', '<leader>de', function() require("dapui").eval() end)
  vim.keymap.set('n', '<leader>dR', function() require("dapui").float_element('repl',{}) end)

  local dap = require('dap')

  dap.defaults.fallback.external_terminal = {
    command = "tmux",
    args = { "split-pane", "-c", vim.fn.getcwd(), "-p", "20", "-d"},
  }
  dap.defaults.fallback.force_external_terminal = true
end
