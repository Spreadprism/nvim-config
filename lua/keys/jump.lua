local M = {}

local jump_base = "<leader>j"

M.n = {
	[jump_base .. "w"] = { "<cmd>HopWord<CR>", "Jump to word" },
	[jump_base .. "p"] = { "<cmd>HopPattern<CR>", "Jump to pattern" },
	[jump_base .. "y"] = { "<cmd>HopYankChar1<CR>", "Yank between jumps" },
	[jump_base .. "l"] = { "<cmd>HopLineStart<CR>", "Jump to line" },
}

return M
