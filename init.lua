vim.g.mapleader = " "

vim.wo.number = true
-- Init package manager
require("init_lazy")
-- Init general keybindings
require("init_keybinds")