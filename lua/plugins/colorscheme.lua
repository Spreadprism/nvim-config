return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd[[colorscheme tokyonight-storm]]
    end
  }
  -- {
  --   "nobbmaestro/nvim-andromeda",
  --   dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
  --   config = function ()
  --     require("andromeda").setup()
  --   end
  -- }
}
