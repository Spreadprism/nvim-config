return function ()
    -- Set breakpoint
    vim.fn.sign_define('DapBreakpoint', {text='', texthl='ErrorMsg', linehl='', numhl=''})

    vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
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

    vim.keymap.set('n', '<leader>dod', function() require("dapui").toggle() end)
end