local prefered_output = {
	go = 2,
	typescriptreact = 2,
	typescript = 2,
	javascript = 2,
}

return {
	{
		"mfussenegger/nvim-dap",
		config = require("configs.nvim-dap"),
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(require("configs.nvim-dap-ui"))
			dap.listeners.after.event_initialized["dapui_config"] = function()
				local current_buffer = vim.api.nvim_get_current_buf()
				local file_type = vim.api.nvim_buf_get_option(current_buffer, "filetype")

				local ui = prefered_output[file_type]
				if ui == nil then
					ui = 3
				end
				require("dapui").open(ui)
			end
		end,
	},
	{
		"rcarriga/cmp-dap",
		config = function()
			require("cmp").setup({
				enabled = function()
					return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
				end,
			})
			require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
				sources = {
					{ name = "dap" },
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local config = {
				cmd = { "/usr/share/java/jdtls/bin/jdtls" },
				root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
				init_options = {
					bundles = {
						vim.fn.glob("/usr/share/java-debug/com.microsoft.java.debug.plugin.jar", 1),
					},
				},
				on_attach = function(client, bufnr)
					require("jdtls.dap").setup_dap_main_class_configs()
				end,
			}
			require("jdtls").start_or_attach(config)
			--
			local events = { "BufWritePost" }
			for _, value in pairs(events) do
				vim.api.nvim_create_autocmd({ value }, {
					callback = function()
						if vim.bo.filetype == "java" then
							require("jdtls.dap").setup_dap_main_class_configs()
						end
					end,
				})
			end
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("dap-python").setup(require("utility.python_env_manager").get_python_path())
			-- vim.keymap.set("n", "<leader>ao", "<cmd>PyrightOrganizeImports<cr>", { desc = "Organize imports" })
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("dap-go").setup({})
		end,
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		ft = { "javascript", "typescript", "typescriptreact" },
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
		},
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function()
			require("illuminate").configure({
				delay = 200,
				large_file_cutoff = 2000,
				large_file_overrides = {
					providers = { "lsp" },
				},
				under_cursor = false,
			})
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		dependencies = "neovim/nvim-lspconfig",
		ft = { "rust" },
		config = function()
			local codelldb_path = "/usr/bin/codelldb"
			local liblldb_path = "/usr/lib/liblldb.so"
			vim.keymap.set(
				"n",
				"<leader>dd",
				"<CMD>RustDebuggables<CR>",
				{ silent = true, desc = "Launch rust debuggables" }
			)
			require("rust-tools").setup({
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				},
				server = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
							checkOnSave = {
								enable = true,
								command = "clippy",
							},
						},
					},
				},
			})
		end,
	},
}
