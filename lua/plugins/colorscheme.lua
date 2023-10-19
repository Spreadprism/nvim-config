return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		dependencies = "xiyaowong/transparent.nvim",
		config = function()
			vim.cmd([[colorscheme tokyonight-storm]])
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
				extra_groups = {
					"NormalFloat",
					"FloatBorder",
					"Telescope",
				},
				exclude_groups = {},
			})
			require("transparent").clear_prefix("NeoTree")
		end,
	},
}
