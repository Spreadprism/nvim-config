return {
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      'haydenmeade/neotest-jest'
    },
    config = function ()
      local neotest_namespace = vim.api.nvim_create_namespace("neotest")
      require("neotest").setup({
        adapters = {
          require("neotest-go")({
            experimental = {
              test_table = true
            },
            args = { "-count=1", "-timeout=60s" }
          }),
          require('neotest-jest')({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          })
        }
      })
    end
  },
}
