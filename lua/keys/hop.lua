local M = {}

M.n = {
	["<leader>w"] = { "<cmd>HopWordCurrentLine<CR>", "Hop to word current line" },
	["<leader>l"] = { "<cmd>HopLineStart<CR>", "Jump to line" },
	["f"] = { "<cmd>HopChar1CurrentLine<CR>", "Jump to char curent line" },
	["F"] = { "<cmd>HopWord<CR>", "Jump to word" },
	["<leader>y"] = { "<cmd>HopYankChar1<CR>", "Yank between hops" },
	-- [jump_base .. "p"] = { "<cmd>HopPattern<CR>", "Jump to pattern" },
	-- ["<leader>fy"] = { "<cmd>HopYankChar1<CR>", "Yank between jumps" },
}

return M
