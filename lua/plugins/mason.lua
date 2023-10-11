local language_servers = {
  "lua_ls",
  "tsserver",
  "gopls",
  "pyright"
}

local useful_utilities = {
  "stylua",
  "shfmt",
  "pyright",
  "rust-analyzer",
  "debugpy",
  "black",
  "mypy",
  "ruff",
  "gopls",
  "lua_ls",
  "eslint-lsp",
  "prettier",
}

return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    build = ":MasonUpdate",
    config = function ()
      require("mason").setup({ ensure_installed = useful_utilities })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = "williamboman/mason.nvim",
    config = function ()
     require("mason-lspconfig").setup({ ensure_installed = language_servers })
    end
  }
}
