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
  ["<A-j>"] = {"<cmd>move +1<CR>==", "Move down", {silent = true}},
  ["<A-k>"] = {"<cmd>move -2<CR>==", "Move up", {silent = true}},
  ["<A-o>"] = {"o<ESC>k", "Insert space under", {silent = true}},
  ["<A-O>"] = {"O<ESC>j", "Insert space over", {silent = true}},
  -- file keymaps
  ["<leader>e"] = {":Neotree toggle<CR>", "Toggle file explorer", {noremap = true, silent = true}},
  -- Buffers manipulation
  ["<leader>xx"] = {":bd!<CR>", "Close current buffer", {noremap = true, silent = true}},
  ["<leader>xa"] = {":%bd<CR>", "Close all buffers", {noremap = true, silent = true}},
  ["<leader>xo"] = {":%bd|e#|bd#<CR>", "Close other buffers", {noremap = true, silent = true}},
  -- Bufferline navigation
  ["<A-h>"] = {":BufferLineCyclePrev<CR>", "Previous buffer", {silent = true}},
  ["<A-l>"] = {":BufferLineCycleNext<CR>", "Next buffer", {silent = true}},
  -- Lsp management
  ["<leader>li"] = {":LspInfo<CR>", "Open Lazy", {silent = true}},
  ["<leader>lr"] = {":LspRestart<CR>", "Open Lazy", {silent = true}},
  ["<leader>L"] = {":Lazy<CR>", "Open Lazy", {silent = true}},
}
M.t = {
  -- terminal
  ["<C-;>"] = {"<C-\\><C-n><CR>:lua require(\"nvterm.terminal\").toggle \"horizontal\"<CR>", "", {silent = true}},
}
M.i = {
  ["<C-l>"] = {"<Right>", "Move right", {silent = true}},
  ["<C-j>"] = {"<Down>", "Move down", {silent = true}},
  ["<C-k>"] = {"<Up>", "Move up", {silent = true}},
  ["<C-e>"] = {"<esc>A", "Go to end of line", {silent = true}},
  ["<C-s>"] = {"<esc>^", "Go to first char of line", {silent = true}},
  ["<C-o>"] = {"<esc>o", "Insert line bellow", {silent = true}},
  ["<S-Tab>"] = {"<C-H>", "Remove tab", {silent = true}},
}
M.v = {
  -- code manipulation
  ["<Tab>"] = {">gv", "Add tab", {silent = true}},
  ["<S-Tab>"] = {"<gv", "Remove tab", {silent = true}},
  ["<A-j>"] = {":m '>+1<CR>gv=gv", "Move down", {silent = true}},
  ["<A-k>"] = {":m '<-2<CR>gv=gv", "Move up", {silent = true}},
  ["<A-J>"] = {"yp", "Copy down", {silent = true}},
  ["<A-K>"] = {"yP", "Copy up", {silent = true}},
  ["/"] = {"gcgv", "toggle comment", {silent = true}},
  -- code selection
  ["A"] = {"ggVG", "Select all", {silent = true}}
}

return M
