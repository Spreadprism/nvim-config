local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	typescriptreact = { "eslint" },
	python = { "ruff" },
}

local ruff = lint.linters.ruff

local function get_file_name()
	local name = vim.api.nvim_buf_get_name(0)
	print(name)
	return name
end

local rules_to_ignore = {
	"F841",
	"F401",
}

ruff.args = {
	"--force-exclude",
	"--quiet",
	"--no-fix",
	get_file_name,
	"--ignore",
	table.concat(rules_to_ignore, ","),
}

local events = { "TextChanged", "BufReadPost", "BufWritePost" }
for _, value in pairs(events) do
	vim.api.nvim_create_autocmd({ value }, {
		callback = function()
			require("lint").try_lint()
		end,
	})
end
