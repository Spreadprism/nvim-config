return {
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"haydenmeade/neotest-jest",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
		},
		config = function()
			local neotest_namespace = vim.api.nvim_create_namespace("neotest")
			require("neotest").setup({
				adapters = {
					-- INFO: Golang
					require("neotest-go")({
						experimental = {
							test_table = true,
						},
						args = { "-count=1", "-timeout=60s" },
					}),
					-- INFO: Javascript
					require("neotest-jest")({
						jestCommand = "npm test --",
						jestConfigFile = "custom.jest.config.ts",
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
					}),
					-- INFO: Python
					require("neotest-python")({
						python = require("utility.python_env_manager").get_python_path(),
						runner = "pytest",
						args = { "--log-level", "DEBUG" },
						dap = { justMyCode = true },
					}),
					-- INFO: Rust
					require("neotest-rust")({
						args = { "--no-capture" },
						dap_adapter = "codelldb",
					}),
				},
			})
		end,
	},
}
