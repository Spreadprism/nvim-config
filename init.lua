vim.g.mapleader = " "

vim.wo.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Init package manager
require("init_lazy")
-- Init general keybindings
require("init_keybinds")