local M = {}

-- Available options silent & noremap
M.n = {

    -- Tmux navigation
    ["<C-w>"] = {"<cmd>TmuxNavigateLeft<CR>", "Navigate window left", { noremap = true }},
    ["<C-l>"] = {"<cmd>TmuxNavigateRight<CR>", "Navigate window right", { noremap = true }},
    ["<C-j>"] = {"<cmd>TmuxNavigateDown<CR>", "Navigate window down", { noremap = true }},
    ["<C-k>"] = {"<cmd>TmuxNavigateUp<CR>", "Navigate window up", { noremap = true }},
    -- Bufferline navigation
    ["L"] = {"<cmd>BufferLineCycleNext<CR>", "Next window", { silent = true }},
    ["H"] = {"<cmd>BufferLineCyclePrev<CR>", "Previous window", { silent = true }},
    -- Open Lazygit
    ["<leader>gg"] = {"<cmd>LazyGit<CR>", "Open lazygit"},
    -- closing and saving
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
M.v = {
    -- code manipulation
    ["<Tab>"] = {">", "Add tab", {silent = true}},
    ["<S-Tab>"] = {"<", "Remove tab", {silent = true}}
}

return M
