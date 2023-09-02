return {
    {
        "mfussenegger/nvim-dap",
        config = require "configs.nvim-dap"
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(require("configs.nvim-dap-ui"))
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
        end
    },
    {
        'mfussenegger/nvim-dap-python',
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui"
        },
        config = function()
            require("dap-python").setup(require("utility.python_env_manager").get_python_path())
            require('dap.ext.vscode').load_launchjs(nil, {})
        end
    }
}