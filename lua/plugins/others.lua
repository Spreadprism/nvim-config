return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"kdheepak/lazygit.nvim",
		event = "VeryLazy",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 200,
					ignore_whitespace = true,
				},
				current_line_blame_formatter = "<author> @ <author_time:%Y-%m-%d> : <summary> ",
			})
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "v0.4.0",
		ft = { "rust", "toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				popup = {
					autofocus = true,
				},
				src = {
					cmp = {
						enabled = true,
					},
				},
			})
		end,
	},
	-- TODO: Install overseer
}
