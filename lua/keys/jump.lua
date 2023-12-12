local M = {}

M.n = {
	["f"] = { "<cmd>HopWord<CR>", "Jump to word" },
	["F"] = { "<cmd>HopLineStart<CR>", "Jump to line" },
	-- [jump_base .. "p"] = { "<cmd>HopPattern<CR>", "Jump to pattern" },
	["<leader>fy"] = { "<cmd>HopYankChar1<CR>", "Yank between jumps" },
}

return M
