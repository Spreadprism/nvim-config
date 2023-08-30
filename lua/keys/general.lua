local M = {}

-- Available options silent & noremap
M.n = {
    -- closing and saving
    ["<C-w>"] = { ":wqa<CR>", "save and exit", {silent = true}},
    ["<C-q>"] = {":qa<CR>", "close", {silent = true}},
    -- code manipulation
    ["<A-J>"] = {"yyp", "Copy down", {silent = true}},
    ["<A-K>"] = {"yyP", {silent = true}},
    ["<A-j>"] = {"ddp", "Move down", {silent = true}},
    ["<A-k>"] = {"ddkP", "Move up", {silent = true}},
    ["<A-o>"] = {"o<ESC>k", "Insert space under", {silent = true}},
    ["<A-O>"] = {"O<ESC>j", "Insert space over", {silent = true}},
    -- file keymaps
    ["<leader>e"] = {":Neotree toggle<CR>", "Toggle file explorer", {noremap = true, silent = true}},
    ["<leader>x"] = {":bd!<CR>", "Close current buffer", {noremap = true, silent = true}},
    -- Buffers manipulation
    ["<leader><Left>"] = {":BufferLineCyclePrev<CR>", "Previous buffer", {silent = true}},
    ["<leader><Right>"] = {":BufferLineCycleNext<CR>", "Next buffer", {silent = true}},

    -- terminal
    ["<C-t>"] = {":lua require(\"nvterm.terminal\").toggle \"horizontal\"<CR>", "Next buffer", {silent = true}},

}
M.t = {
    -- terminal
    ["<C-t>"] = {"<C-\\><C-n><CR>:lua require(\"nvterm.terminal\").toggle \"horizontal\"<CR>", "Next buffer", {silent = true}},
}
M.i = {
    ["<C-j>"] = {"<Down>", "Move down"},
    ["<C-k>"] = {"<Up>", "Move up"},
    -- <C-h> doesn't work on windows terminal
    -- ["<C-h>"] = {"<Left>", "Move left"},
    ["<C-l>"] = {"<Right>", "Move right"},
    ["<C-e>"] = {"<C-o>$", "Go to end of line"}
}
M.v = {
    -- code manipulation
    ["<Tab>"] = {">", "Add tab", {silent = true}},
    ["<S-Tab>"] = {"<", "Remove tab", {silent = true}}
}

return M
