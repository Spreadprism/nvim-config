local M = {}

-- Available options silent & noremap
M.n = {
    -- closing and saving
    ["<C-w>"] = { ":wqa<CR>", "save and exit", {silent = true}},
    ["<C-q>"] = {":qa<CR>", "close", {silent = true}},
    ["<C-Q>"] = {":qa!<CR>", "close", {silent = true}},
    --
    ["<A-J>"] = {"yyp", "Copy up", {silent = true}},
    ["<A-K>"] = {"yyP", "Copy down", {silent = true}},
    ["<A-j>"] = {"ddp", "Move down", {silent = true}},
    ["<A-k>"] = {"ddkP", "Move up", {silent = true}},
    -- file keymaps
    ["<leader>e"] = {":Neotree toggle<CR>", "Toggle file explorer", {noremap = true, silent = true}},
    ["<leader>x"] = {":bd!<CR>", "Close current buffer", {noremap = true, silent = true}}
}

return M