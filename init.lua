vim.g.mapleader = " "
vim.wo.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.updatetime = 300

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
-- 	vim.lsp.diagnostic.on_publish_diagnostics, {
-- 		virtual_text = false,
-- 		underline = true,
-- 		signs = true,
-- 	}
-- )
-- vim.filetype.add({
--   extension = {
--     env = "dotenv",
--   },
--   filename = {
--     [".env"] = "dotenv",
--   },
--   pattern = {
--     ["%.env%.[%w_.-]+"] = "dotenv",
--   },
-- })

-- Init package manager
require("init_lazy")
-- Init general keybindings
require("init_keybinds")

vim.fn.sign_define("DiagnosticSignError", {text = "", texthl = "DiagnosticSignError"})
vim.cmd([[highlight DiagnosticUnderlineError guifg=#db4b4b]])
vim.fn.sign_define("DiagnosticSignWarn", {text = "", texthl = "DiagnosticSignWarn"})
vim.cmd([[highlight DiagnosticUnderlineWarn guifg=#e0af68]])
vim.fn.sign_define("DiagnosticSignInfo", {text = "", texthl = "DiagnosticSignInfo"})
vim.cmd([[highlight DiagnosticUnderlineInfo guifg=#0db9d7]])
vim.fn.sign_define("DiagnosticSignHint", {text = "󰌵", texthl = "DiagnosticSignHint"})
vim.cmd([[highlight DiagnosticUnderlineInfo guifg=#1abc9c]])
