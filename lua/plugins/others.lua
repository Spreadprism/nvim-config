return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  },
  {
    "nvim-lua/plenary.nvim"
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
