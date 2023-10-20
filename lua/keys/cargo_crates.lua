local M = {}

local crates = require("crates")
M.n = {
	["<leader>cv"] = { crates.show_versions_popup, "Versions popup", { silent = true } },
	["<leader>cf"] = { crates.show_features_popup, "Features popup", { silent = true } },
	["<leader>cd"] = { crates.show_dependencies_popup, "Dependencies popup", { silent = true } },

	["<leader>cu"] = { crates.update_crate, "Update crate", { silent = true } },
	["<leader>cU"] = { crates.upgrade_crate, "Upgrade crate", { silent = true } },
	["<leader>ca"] = { crates.update_all_crates, "Update all crates", { silent = true } },
	["<leader>cA"] = { crates.upgrade_all_crates, "Upgrade all crates", { silent = true } },

	["<leader>cH"] = { crates.open_homepage, "Upgrade all crates", { silent = true } },
	["<leader>cR"] = { crates.open_repository, "Upgrade all crates", { silent = true } },
	["<leader>cD"] = { crates.open_documentation, "Upgrade all crates", { silent = true } },
	["<leader>cC"] = { crates.open_crates_io, "Upgrade all crates", { silent = true } },
}

M.v = {
	["<leader>cu"] = {
		function()
			require("crates").update_crates()
		end,
		"Update selected crates",
		{ silent = true },
	},
	["<leader>cU"] = {
		function()
			require("crates").upgrade_crates()
		end,
		"Upgrade selected crates",
		{ silent = true },
	},
}
return M
