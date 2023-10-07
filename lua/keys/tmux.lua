local M = {}

M.n = {
  ["<C-w>"] = {"<cmd>TmuxNavigateLeft<CR>", "Navigate window left", { noremap = true }},
  ["<C-l>"] = {"<cmd>TmuxNavigateRight<CR>", "Navigate window right", { noremap = true }},
  ["<C-j>"] = {"<cmd>TmuxNavigateDown<CR>", "Navigate window down", { noremap = true }},
  ["<C-k>"] = {"<cmd>TmuxNavigateUp<CR>", "Navigate window up", { noremap = true }},
}

return M
