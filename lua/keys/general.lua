local M = {}

-- Available options silent & noremap
M.n = {
	-- Open Lazygit
	["<leader>gg"] = { "<cmd>LazyGit<CR>", "Open lazygit" },
	-- moving
	["L"] = { "g_", "move the cursor to the last non-whitespace character", { noremap = true } },
	-- closing and saving
	["<C-q>"] = { ":qa<CR>", "close", { silent = true } },
	-- file keymaps
	["<leader>e"] = { ":Neotree toggle<CR>", "Toggle file explorer", { noremap = true, silent = true } },
	["<leader>E"] = {
		":Neotree filesystem reveal<CR>",
		"Toggle file explorer with current file as focus",
		{ noremap = true, silent = true },
	},
	-- Buffers manipulation
	-- ["<leader>xx"] = {":bd!<CR>", "Close current buffer", {noremap = true, silent = true}},
	-- ["<leader>xa"] = {":%bd<CR>", "Close all buffers", {noremap = true, silent = true}},
	-- ["<leader>xo"] = {":%bd|e#|bd#<CR>", "Close other buffers", {noremap = true, silent = true}},
	["<leader>ol"] = { "<CMD>Lazy<CR>", "Open Lazy", { silent = true } },
	["<leader>om"] = { "<CMD>Mason<CR>", "Open Mason", { silent = true } },
	-- INFO: Needs npm install -g clipboard-cli
	["<leader>yf"] = {
		function()
			local bufname = vim.api.nvim_buf_get_name(0)
			vim.cmd("silent! !echo " .. bufname .. " | clipboard")
			print("Saved buffer's relative path to the clipboard.")
		end,
		"Save buffer's relative path to the clipboard.",
		{ silent = true },
	},
	["<leader>yF"] = {
		function()
			local bufname = vim.api.nvim_buf_get_name(0)
			vim.cmd("silent! !echo " .. bufname .. " | clipboard")
			print("Saved buffer's absolute path in the clipboard.")
		end,
		"Save buffer's absolute path in the clipboard.",
		{ silent = true },
	},
}

M.t = {
	-- terminal
	["<C-;>"] = { '<C-\\><C-n><CR>:lua require("nvterm.terminal").toggle "horizontal"<CR>', "", { silent = true } },
}
M.i = {
	["<C-l>"] = { "<Right>", "Move right", { silent = true } },
	["<C-j>"] = { "<Down>", "Move down", { silent = true } },
	["<C-k>"] = { "<Up>", "Move up", { silent = true } },
	["<C-e>"] = { "<esc>A", "Go to end of line", { silent = true } },
	["<C-s>"] = { "<esc>^", "Go to first char of line", { silent = true } },
	["<C-o>"] = { "<esc>o", "Insert line bellow", { silent = true } },
	["<S-Tab>"] = { "<C-H>", "Remove tab", { silent = true } },
}

M.v = {
	-- code manipulation
	["<Tab>"] = { ">gv", "Add tab", { silent = true } },
	["<S-Tab>"] = { "<gv", "Remove tab", { silent = true } },
	["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move down", { silent = true } },
	["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move up", { silent = true } },
	["<A-J>"] = { "yp", "Copy down", { silent = true } },
	["<A-K>"] = { "yP", "Copy up", { silent = true } },
	["/"] = { "gcgv", "toggle comment", {}, true },
	["L"] = { "g_", "move the cursor to the last non-whitespace character", { noremap = true } },
	["Y"] = { '"+y', "Yank to clipboard", { silent = true } },
}

return M
