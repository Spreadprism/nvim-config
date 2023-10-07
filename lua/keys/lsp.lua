local M = {}

M.n = {
  ["<leader>li"] = {":LspInfo<CR>", "Open Lazy", {silent = true}},
  ["<leader>lr"] = {":LspRestart<CR>", "Open Lazy", {silent = true}},
}

return M
