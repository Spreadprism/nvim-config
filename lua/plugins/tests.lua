return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go"
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
          })
        }
      })
    end
  },
}
