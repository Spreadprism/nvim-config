return {
  {
    "mfussenegger/nvim-dap",
    config = require "configs.nvim-dap"
  },
  {
    "rcarriga/nvim-dap-ui",
    event= "VeryLazy",
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
      require('dap.ext.vscode').load_launchjs(nil, {})
      require("dap-python").setup(require("utility.python_env_manager").get_python_path())
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui"
    },
    config = function ()
      require("dap-go").setup({})
      require('dap.ext.vscode').load_launchjs(nil, {})
    end
  }
}
