return {
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function ()
      require "configs.nvim-lint"
    end
  }
}
