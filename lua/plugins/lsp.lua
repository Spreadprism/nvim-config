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
        lazy = false,
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        config = function()
            local mason = require("mason")

            mason.setup({
                ensure_installed = {
                    "stylua",
                    "shfmt",
                    "pyright",
                    "rust-analyzer",
                    "debugpy",
                    "black",
                    "mypy",
                    "ruff",
                    "gopls",
                },
            })
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        ft = {"python"},
        config = function()
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.black,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({bufnr = bufnr})
                            end
                        })
                    end
                end
            })
        end
    }
}
