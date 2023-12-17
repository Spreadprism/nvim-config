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
		"crnvl96/lazydocker.nvim",
		event = "VeryLazy",
		opts = {}, -- automatically calls `require("lazydocker").setup()`
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				current_line_blame = false,
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
	{
		"weirongxu/plantuml-previewer.vim",
		event = "VeryLazy",
		dependencies = {
			"tyru/open-browser.vim",
			"aklt/plantuml-syntax",
		},
	},
	{
		"stevearc/overseer.nvim",
		event = "VeryLazy",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local overseer = require("overseer")
			overseer.setup()
			require("dap.ext.vscode").json_decode = require("overseer.json").decode
		end,
	},
	{
		"smoka7/hop.nvim",
		event = "VeryLazy",
		version = "*",
		opts = {},
	},
	-- {
	-- 	"Dhanus3133/LeetBuddy.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("leetbuddy").setup({})
	-- 	end,
	-- 	keys = {
	-- 		{ "<leader>lq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
	-- 		{ "<leader>ll", "<cmd>LBQuestion<cr>", desc = "View Question" },
	-- 		{ "<leader>lr", "<cmd>LBReset<cr>", desc = "Reset Code" },
	-- 		{ "<leader>lt", "<cmd>LBTest<cr>", desc = "Run Code" },
	-- 		{ "<leader>ls", "<cmd>LBSubmit<cr>", desc = "Submit Code" },
	-- 	},
	-- },
	-- {
	-- 	"kawre/leetcode.nvim",
	-- 	build = ":TSUpdate html",
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"nvim-lua/plenary.nvim", -- required by telescope
	-- 		"MunifTanjim/nui.nvim",
	--
	-- 		-- optional
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"rcarriga/nvim-notify",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	opts = {
	-- 		-- configuration goes here
	-- 	},
	-- },
}
