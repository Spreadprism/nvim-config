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
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local config = {
        cmd = {'/usr/share/java/jdtls/bin/jdtls'},
        root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
        init_options = {
          bundles = {
            vim.fn.glob("/usr/share/java-debug/com.microsoft.java.debug.plugin.jar", 1)
          }
        }
      }
      require('jdtls').start_or_attach(config)
      -- 
      vim.keymap.set('n', '<leader>dlc', function() require('jdtls.dap').setup_dap_main_class_configs() end)
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
    end
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = { "javascript", "typescript", "typescriptreact" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
      }
    },
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }
      })
    end
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function ()
      require('illuminate').configure({
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
          providers = { "lsp" },
        },
        under_cursor = false,
      })
    end
  }
}
