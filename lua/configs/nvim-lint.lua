local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	typescriptreact = { "eslint" },
	-- python = { "ruff" },
}

-- INFO: no longer need the linter config below because I'm using the lsp
--
-- local ruff = lint.linters.ruff
--
-- local function get_file_name()
-- 	return vim.api.nvim_buf_get_name(0)
-- end
--
-- local rules_to_ignore = {
-- 	"F841",
-- 	"F401",
-- 	"F821",
-- }
--
-- ruff.args = {
-- 	"--force-exclude",
-- 	"--quiet",
-- 	"--no-fix",
-- 	get_file_name,
-- 	"--ignore",
-- 	table.concat(rules_to_ignore, ","),
-- }

local events = { "TextChanged", "BufReadPost", "BufWritePost" }
for _, value in pairs(events) do
	vim.api.nvim_create_autocmd({ value }, {
		callback = function()
			require("lint").try_lint()
		end,
	})
end
