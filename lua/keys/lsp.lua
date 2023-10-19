local M = {}

M.n = {
  ["<leader>li"] = {":LspInfo<CR>", "Open lsp info", {silent = true}},
  ["<leader>lr"] = {":LspRestart<CR>", "Restart lsp", {silent = true}},
}

return M
