local language_servers = {
  "lua_ls",
  "tsserver",
  "gopls",
  "pyright"
}

local external_plugins = {
  "stylua",
  "shfmt",
  "debugpy",
  "black",
  "mypy",
  "ruff",
  "eslint-lsp",
  "prettier",
}

return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    build = ":MasonUpdate",
    config = function ()
      require("mason").setup({ ensure_installed = external_plugins })
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
