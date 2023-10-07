local M = {}

M.n = {
  ["<leader>hm"] = {"<CMD>lua require('harpoon.mark').toggle_file()<CR>", "Harpoon mark toggle"},
  ["<A-l>"] = {"<CMD>lua require('harpoon.ui').nav_next()<CR>", "Next mark"},
  ["<A-h>"] = {"<CMD>lua require('harpoon.ui').nav_prev()<CR>", "Previous mark"},
  ["<leader>hcm"] = {"<CMD>lua require('harpoon.mark').clear_all()<CR>", "Clear all marks"},
  ["<leader>sm"] = {"<CMD>Telescope harpoon marks<CR>", "Search marks"},
}

return M
