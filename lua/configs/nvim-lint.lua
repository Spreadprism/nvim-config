local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	typescriptreact = { "eslint" },
	python = { "ruff" },
}

local ruff = lint.linters.ruff

local function get_file_name()
	return vim.api.nvim_buf_get_name(0)
end

ruff.args = {
	-- INFO: Base arguments
	"--force-exclude",
	"--quiet",
	"--stdin-filename",
	get_file_name,
	"--no-fix",
	"-",
}

local events = { "TextChanged", "BufReadPost", "BufWritePost" }
for _, value in pairs(events) do
	vim.api.nvim_create_autocmd({ value }, {
		callback = function()
			require("lint").try_lint()
		end,
	})
end
