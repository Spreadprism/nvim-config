local M = {}

local jupynium_bind = "<leader>j"

local get_current_file_name = function()
	local name = vim.api.nvim_buf_get_name(0)
	return string.match(name, ".+/([^/]+)%.ju%.py$")
end
local get_current_file_sync = function()
	return get_current_file_name() .. ".sync"
end
local get_current_file_directory = function()
	local name = vim.api.nvim_buf_get_name(0)
	return string.match(name, "(.+/)")
end
M.n = {
	["<leader>oj"] = { "<cmd>JupyniumStartAndAttachToServer<CR>", "Open jupyter" },
	[jupynium_bind .. "s"] = {
		function()
			local sync_filename = get_current_file_sync()
			local actual_file_name = sync_filename .. ".ipynb"
			local directory = get_current_file_directory()

			local filepath = directory .. actual_file_name
			vim.cmd("silent! !rm -f " .. filepath) -- INFO: Remove the original sync file
			vim.cmd("JupyniumStartSync " .. sync_filename)
		end,
		"Start sync",
	},
	[jupynium_bind .. "S"] = {
		function()
			local sync_filename = get_current_file_sync()
			vim.cmd("JupyniumStopSync")
			local actual_file_name = sync_filename .. ".ipynb"
			local directory = get_current_file_directory()

			local filepath = directory .. actual_file_name
			vim.cmd("silent! !rm -f " .. filepath) -- INFO: Remove the original sync file
		end,
		"Stop sync",
	},
	[jupynium_bind .. "i"] = {
		function()
			local name = vim.api.nvim_buf_get_name(0)
			local filename = string.match(name, ".+/([^/]+)%.ipynb$")

			vim.cmd("!conda run -n base ipynb2jupytext " .. filename .. ".ipynb " .. filename .. ".ju.py")
			vim.cmd("e " .. filename .. ".ju.py")
		end,
	},
}

return M
