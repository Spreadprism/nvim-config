local os_symbol = nil
local os_info_path = "/etc/issue"

local os_logos = {
	Arch = "󰣇",
	Ubuntu = "",
}

local get_first_word = function(input_string)
	local words = {}
	for word in input_string:gmatch("%S+") do
		table.insert(words, word)
	end
	return words[1]
end

local get_os_symbol = function()
	if os_symbol == nil then
		local file = io.open(os_info_path, "r")
		if file == nil then
			os_symbol = "󰞋"
		else
			local file_content = file:read("*a")
			file:close()
			local os = get_first_word(file_content)
			os_symbol = os_logos[os]
		end
	end
	return os_symbol
end

local function separator()
	return ""
end

return {
	{
		get_os_symbol,
	},
	{
		"tabs",
		mode = 0,
		separators = "",
		cond = function()
			return #vim.api.nvim_list_tabpages() > 1
		end,
		use_mode_colors = true,
		-- tabs_color = {
		-- 	inactive = { bg = "#3b4261" }, -- Color for inactive tab.
		-- 	active = { fg = "#e4ac6c", bg = "#3b4261" }, -- Color for inactive tab.
		-- },
	},
	-- function()
	-- 	return require("copilot_status").status_string()
	-- end,
}
