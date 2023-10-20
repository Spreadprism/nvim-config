local language_servers = {
	"lua_ls",
	"tsserver",
	"gopls",
	"pyright",
}

local daps_plugins = {
	"java-debug-adapter",
}

local external_tools = {
	"debugpy",
	"black",
	"prettier",
	"js-debug-adapter",
}

return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					-- border = "rounded",
					width = 0.8,
					height = 0.8,
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = "williamboman/mason.nvim",
		config = function()
			require("mason-tool-installer").setup({ ensure_installed = external_tools })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = "williamboman/mason.nvim",
		config = function()
			require("mason-lspconfig").setup({ ensure_installed = language_servers })
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = "williamboman/mason.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = daps_plugins,
				automatic_installation = true,
			})
		end,
	},
}
