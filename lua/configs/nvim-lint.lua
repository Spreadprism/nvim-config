local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	typescriptreact = { "eslint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
