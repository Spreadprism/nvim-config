Current_ft = function()
	return vim.api.nvim_buf_get_option(0, "filetype")
end

config = require("nvim-surround.config")

return {
	["s"] = {
		add = { "str(", ")" },
		find = function()
			if vim.g.loaded_nvim_treesitter then
				local selection = config.get_selection({
					query = {
						capture = "@call.outer",
						type = "textobjects",
					},
				})
				if selection then
					return selection
				end
			end
			return config.get_selection({ pattern = "[^=%s%(%){}]+%b()" })
		end,
		delete = "^(.-%()().-(%))()$",
	},
}
