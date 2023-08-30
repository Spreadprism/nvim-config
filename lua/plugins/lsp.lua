return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-buffer"},
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            {"hrsh7th/cmp-nvim-lsp"},
        },
        opts = {
            diagnostics = {
                underline = true,
                virtual_text = {
                    spacing = 2,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
            },
            inlay_hints = {
                enabled = false,
            }
        },
        config = require "configs.nvim-lsp"
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
              "stylua",
              "shfmt",
              "pyright",
              "anakin_language_server",
              "rust-analyzer"
            },
          },
    },
    {
        "HallerPatrick/py_lsp.nvim",
        init = function ()
            require'py_lsp'.setup {
                -- This is optional, but allows to create virtual envs from nvim
                host_python = "/usr/bin/python3",
                default_venv_name = "venv" -- For local venv
              }
        end
    }
}