local M = {}

M.n = {
	["<leader>li"] = { ":LspInfo<CR>", "Open lsp info", { silent = true } },
	["<leader>lr"] = { ":LspRestart<CR>", "Restart lsp", { silent = true } },
	["<leader>ls"] = { ":LspStop<CR>", "Stop lsp", { silent = true } },
}

return M
