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
	[jupynium_bind .. "li"] = {
		function()
			local current_buffer_path = vim.fn.expand("%:p")
			local name = vim.api.nvim_buf_get_name(0)
			local filename = string.match(name, ".+/([^/]+)%.ipynb$")
			local current_buffer_dir = vim.fn.expand("%:p:h")
			local new_buffer_path = current_buffer_dir .. "/" .. filename .. ".ju.py"

			vim.cmd("!conda run -n base ipynb2jupytext " .. current_buffer_path .. " " .. new_buffer_path)
			vim.cmd("e " .. new_buffer_path)
		end,
	},
	[jupynium_bind .. "x"] = { "<cmd>JupyniumExecuteSelectedCells<CR>", "Execute cell" },
	[jupynium_bind .. "c"] = { "<cmd>JupyniumClearSelectedCellsOutputs<CR>", "Clear cell" },
	[jupynium_bind .. "ks"] = { "<cmd>JupyniumKernelSelect<cr>", "Select kernel" },
	[jupynium_bind .. "kr"] = { "<cmd>JupyniumKernelRestart<cr>", "Restart kernel" },
	[jupynium_bind .. "ki"] = { "<cmd>JupyniumKernelInterrupt<cr>", "Interrupt kernel" },
	[jupynium_bind .. "kk"] = { "<cmd>JupyniumKernelHover<cr>", "Hover variable" },
}

M.v = {
	[jupynium_bind .. "x"] = { "<cmd>JupyniumExecuteSelectedCells<CR>", "Execute cell" },
}

return M
