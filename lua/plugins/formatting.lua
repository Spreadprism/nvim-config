return {
	{
		"mhartington/formatter.nvim",
		event = "VeryLazy",
		opts = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				command = "FormatWriteLock",
			})
			return {
				filetype = {
					javascript = {
						require("formatter.filetypes.javascript").prettier,
					},
					typescript = {
						require("formatter.filetypes.typescript").prettier,
					},
					typescriptreact = {
						require("formatter.filetypes.typescript").prettier,
					},
					json = {
						require("formatter.filetypes.json").prettier,
					},
					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
					python = {
						require("formatter.filetypes.python").black,
					},
					go = {
						require("formatter.filetypes.go").gofmt,
					},
					rust = {
						require("formatter.filetypes.rust").rustfmt,
					},
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
				},
			}
		end,
	},
}
