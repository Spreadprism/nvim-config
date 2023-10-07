local M = {}

M.n = {
  ["<A-J>"] = {"Vyp", "Copy down", {silent = true}},
  ["<A-K>"] = {"VyP", "Copy up", {silent = true}},
  ["<A-j>"] = {"<cmd>move +1<CR>==", "Move down", {silent = true}},
  ["<A-k>"] = {"<cmd>move -2<CR>==", "Move up", {silent = true}},
  ["<A-o>"] = {"o<ESC>k", "Insert space under", {silent = true}},
  ["<A-O>"] = {"O<ESC>j", "Insert space over", {silent = true}},
}

return M
