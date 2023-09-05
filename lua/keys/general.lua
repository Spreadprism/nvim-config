local M = {}

-- Available options silent & noremap
M.n = {

    -- Tmux navigation
    ["<C-w>"] = {"<cmd>TmuxNavigateLeft<CR>", "Navigate window left", { noremap = true }},
    ["<C-l>"] = {"<cmd>TmuxNavigateRight<CR>", "Navigate window right", { noremap = true }},
    ["<C-j>"] = {"<cmd>TmuxNavigateDown<CR>", "Navigate window down", { noremap = true }},
    ["<C-k>"] = {"<cmd>TmuxNavigateUp<CR>", "Navigate window up", { noremap = true }},
    
    -- Open Lazygit
    ["<leader>gg"] = {"<cmd>LazyGit<CR>", "Open lazygit"},
    -- closing and saving
    ["<C-q>"] = {":qa<CR>", "close", {silent = true}},
    -- code manipulation
    ["<A-J>"] = {"Vyp", "Copy down", {silent = true}},
    ["<A-K>"] = {"VyP", "Copy up", {silent = true}},
    ["<A-j>"] = {"<cmd>move +1<CR>", "Move down", {silent = true}},
    ["<A-k>"] = {"<cmd>move -2<CR>", "Move up", {silent = true}},
    ["<A-o>"] = {"o<ESC>k", "Insert space under", {silent = true}},
    ["<A-O>"] = {"O<ESC>j", "Insert space over", {silent = true}},
    -- file keymaps
    ["<leader>e"] = {":Neotree toggle<CR>", "Toggle file explorer", {noremap = true, silent = true}},
    ["<leader>x"] = {":bd!<CR>", "Close current buffer", {noremap = true, silent = true}},
    -- Buffers manipulation
    ["<leader><Left>"] = {":BufferLineCyclePrev<CR>", "Previous buffer", {silent = true}},
    ["<leader><Right>"] = {":BufferLineCycleNext<CR>", "Next buffer", {silent = true}},
    ["<A-h>"] = {":BufferLineCyclePrev<CR>", "Previous buffer", {silent = true}},
    ["<A-l>"] = {":BufferLineCycleNext<CR>", "Next buffer", {silent = true}},

    
    ["<leader>L"] = {":Lazy<CR>", "Open Lazy", {silent = true}},
    ["<leader>li"] = {":LspInfo<CR>", "Open Lazy", {silent = true}},
    ["<leader>lr"] = {":LspRestart<CR>", "Open Lazy", {silent = true}},

    -- terminal
    ["<C-t>"] = {":lua require(\"nvterm.terminal\").toggle \"horizontal\"<CR>", "Next buffer", {silent = true}},

}
M.t = {
    -- terminal
    ["<C-t>"] = {"<C-\\><C-n><CR>:lua require(\"nvterm.terminal\").toggle \"horizontal\"<CR>", "Next buffer", {silent = true}},
}
M.i = {
    ["<C-l>"] = {"<Right>", "Move right", {silent = true}},
    ["<C-j>"] = {"<Down>", "Move down", {silent = true}},
    ["<C-k>"] = {"<Up>", "Move up", {silent = true}},
    ["<C-e>"] = {"<esc>A", "Go to end of line", {silent = true}},
    ["<C-s>"] = {"<esc>^", "Go to first char of line", {silent = true}},
    ["<C-o>"] = {"<esc>o", "Insert line bellow", {silent = true}},
}
M.v = {
    -- code manipulation
    ["<Tab>"] = {">", "Add tab", {silent = true}},
    ["<S-Tab>"] = {"<", "Remove tab", {silent = true}},
}

return M
