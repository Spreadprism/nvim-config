local language_servers = {
  "lua_ls",
  "tsserver",
  "gopls",
  "pyright"
}

local external_tools = {
  "debugpy",
  "black",
  "eslint-lsp",
  "prettier",
  "js-debug-adapter"
}

return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = "williamboman/mason.nvim",
    config = function()
      require("mason-tool-installer").setup { ensure_installed = external_tools }
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = "williamboman/mason.nvim",
    config = function()
      require("mason-lspconfig").setup { ensure_installed = language_servers }
    end
  }
}
