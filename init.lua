-- INFO: General configuration
vim.g.mapleader = " "
vim.wo.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.showtabline = 0
vim.o.updatetime = 300

-- INFO: Init packages
require("init_lazy")
-- INFO: Init keybinds
require("keybinds_manager").init_keybinds()

-- INFO: Defining the signs and highlights after loading plugins to overwrite them.
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.cmd([[highlight DiagnosticUnderlineError guifg=#db4b4b]])
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.cmd([[highlight DiagnosticUnderlineWarn guifg=#e0af68]])
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.cmd([[highlight DiagnosticUnderlineInfo guifg=#0db9d7]])
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
vim.cmd([[highlight DiagnosticUnderlineInfo guifg=#1abc9c]])
