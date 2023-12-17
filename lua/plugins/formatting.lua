return {
	{
		"mhartington/formatter.nvim",
		event = "VeryLazy",
		config = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				command = "FormatWriteLock",
			})
			require("formatter").setup({
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
						function()
							local util = require("formatter.util")
							if util.get_current_buffer_file_name() == "starship.toml" then
								return nil
							end
							local save_cursor = vim.fn.getpos(".")
							vim.cmd([[%s/\s\+$//e]])
							vim.fn.setpos(".", save_cursor)
						end,
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
			})
		end,
	},
}
