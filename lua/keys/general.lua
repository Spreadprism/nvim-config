local M = {}

-- Available options silent & noremap
M.n = {
    -- closing and saving
    ["<C-w>"] = { ":wqa<CR>", "save and exit", {silent = true}},
    ["<C-q>"] = {":qa<CR>", "close", {silent = true}},
    -- code manipulation
    ["<A-J>"] = {"i<ESC>lyypgi<ESC>lj", "Copy down", {silent = true}},
    ["<A-K>"] = {"i<ESC>lyyPgi<ESC>lk", {silent = true}},
    ["<A-j>"] = {"ddp", "Move down", {silent = true}},
    ["<A-k>"] = {"ddkP", "Move up", {silent = true}},
    ["<A-o>"] = {"o<ESC>k", "Insert space under", {silent = true}},
    ["<A-O>"] = {"O<ESC>j", "Insert space over", {silent = true}},
    -- file keymaps
    ["<leader>e"] = {":Neotree toggle<CR>", "Toggle file explorer", {noremap = true, silent = true}},
    ["<leader>x"] = {":bd!<CR>", "Close current buffer", {noremap = true, silent = true}},
    -- Buffers manipulation
    ["<C-n>"] = {":BufferLineCyclePrev<CR>", "Previous buffer", {silent = true}},
    ["<C-m>"] = {":BufferLineCycleNext<CR>", "Next buffer", {silent = true}},
}
M.i = {
    ["<C-h>"] = {"<Left>", "Move left"},
    ["<C-j>"] = {"<Down>", "Move down"},
    ["<C-k>"] = {"<Up>", "Move up"},
    ["<C-l>"] = {"<Right>", "Move right"},
}
M.v = {
    -- code manipulation
    ["<Tab>"] = {">", "Add tab", {silent = true}},
    ["<S-Tab>"] = {"<", "Remove tab", {silent = true}}
}

return M
