local M = {}

M.n = {
	["<leader>hm"] = { "<CMD>lua require('harpoon.mark').toggle_file()<CR>", "Harpoon mark toggle" },
	["<A-l>"] = { "<CMD>lua require('harpoon.ui').nav_next()<CR>", "Next mark" },
	["<A-h>"] = { "<CMD>lua require('harpoon.ui').nav_prev()<CR>", "Previous mark" },
	["<leader>hcm"] = {
		function()
			require("harpoon.mark").clear_all()
			print("Marks cleared")
		end,
		"Clear all marks",
	},
	["<leader>sm"] = { "<CMD>Telescope harpoon marks<CR>", "Search marks" },
}

return M
