local M = {}
Mode_keybindings = {
	n = "normal",
	i = "insert",
	v = "visual",
	t = "terminal",
	-- Add more modes if needed
}

-- TODO: I should add comments on how this function works
-- TODO: I should add error handling, if there is one exception during load, all keybinds stops working
local load_mappings = function(mappings)
	for mode, keybindings in pairs(mappings) do
		if Mode_keybindings[mode] then
			for key, action_config in pairs(keybindings) do
				if #action_config >= 1 then
					local action = action_config[1]
					local description = action_config[2]
					local opts = action_config[3]
					local force_api = action_config[4]
					if opts == nil then
						if description ~= nil then
							opts = { desc = description }
						else
							opts = {}
						end
					else
						if description ~= nil then
							opts.desc = description
						end
					end
					if force_api == nil or not force_api then
						vim.keymap.set(mode, key, action, opts)
					else
						vim.api.nvim_set_keymap(mode, key, action, opts)
					end
				else
					print(key .. " action is empty")
				end
			end
		end
	end
end

M.init_keybinds = function()
	local module_utility = require("utility.module_utility")
	local mapping_path = module_utility.BASE_NEOVIM_LUA_PATH .. "/keys"
	local modules = module_utility.get_modules_in_dir(mapping_path)

	-- For each modules, load their keymaps
	for _, module in pairs(modules) do
		load_mappings(require(module))
	end
end

return M
