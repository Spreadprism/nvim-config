local buffer_blacklist = { "neo-tree filesystem [1]" }

---@diagnostic disable-next-line: lowercase-global
function DisplayFilename()
	-- INFO: Check if we are currently in a terminal
	if vim.fn.mode() == "t" then
		return false
	end

	local current_buffer = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")

	-- INFO: Don't need to check all of our blacklisted filename, its empty
	if current_buffer == "" then
		return false
	end

	local display = true
	for _, str in ipairs(buffer_blacklist) do
		if current_buffer == str then
			-- INFO: Current buffer is in the blacklist, no need to search futher
			display = false
			break
		end
	end

	return display
end

local utils = require("harpoon.utils")
local mark = require("harpoon.mark")

function Displaymark()
	if DisplayFilename() then
		local current_buffer = utils.normalize_path(vim.api.nvim_buf_get_name(0))

		for idx = 1, mark.get_length() do
			if mark.get_marked_file_name(idx) == current_buffer then
				return true
			end
		end
	end
	return false
end

return {
	"branch",
	{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 }, cond = DisplayFilename },
	{
		"filename",
		path = 0,
		separator = "",
		padding = { left = 1, right = 0 },
		symbols = { modified = "󱇧", readonly = "󰷊", unnamed = "" },
		cond = DisplayFilename,
	},
	{
		function()
			return "󰐃"
		end,
		color = { fg = "#db4b4b" },
		separator = "",
		cond = Displaymark,
	},
}
