local M = {}

-- Available options silent & noremap
M.n = {
	["<leader>og"] = { "<cmd>LazyGit<CR>", "Open lazygit" },
	["<leader>od"] = { "<cmd>LazyDocker<CR>", "Open lazydocker" },
	-- moving
	["L"] = { "g_", "move the cursor to the last non-whitespace character", { noremap = true } },
	["H"] = { "^", "move the cursor to the first non-whitespace character", { noremap = true } },
	-- closing and saving
	["<C-q>"] = { "<CMD>q<CR>", "close", { silent = true } },
	-- file keymaps
	["<leader>e"] = { ":Neotree toggle<CR>", "Toggle file explorer", { noremap = true, silent = true } },
	["<leader>E"] = {
		":Neotree filesystem reveal<CR>",
		"Toggle file explorer with current file as focus",
		{ noremap = true, silent = true },
	},
	["<M-v>"] = { "<CMD>vsplit<CR>", "Vertical split" },
	["<M-V>"] = { "<CMD>split<CR>", "Horizontal split" },
	["<C-;>"] = { "<esc>", "Escape" },
	["<C-Left>"] = {
		function()
			require("smart-splits").resize_left()
		end,
		"Horizontal split",
	},
	["<C-Right>"] = {
		function()
			require("smart-splits").resize_right()
		end,
		"Horizontal split",
	},
	["<C-Down>"] = {
		function()
			require("smart-splits").resize_down()
		end,
		"Horizontal split",
	},
	["<C-Up>"] = {
		function()
			require("smart-splits").resize_up()
		end,
		"Horizontal split",
	},
	["<leader>S"] = {
		function()
			require("spectre").toggle()
		end,
		"Spectre",
		{ silent = true },
	},

	["tn"] = {
		"<CMD>tabnew<CR>",
		"New tab",
	},
	["T"] = {
		"<cmd>terminal<CR>i",
		"Convert current buffer to terminal",
		{ silent = true },
	},
	["tt"] = {
		"<CMD>tabnew +terminal<CR>i",
		"new terminal tab",
	},
	["tl"] = {
		"<CMD>tabnext<CR>",
		"Next tab",
	},
	["th"] = {
		"<CMD>tabprevious<CR>",
		"Previous tab",
	},
	-- Buffers manipulation
	-- ["<leader>xx"] = {":bd!<CR>", "Close current buffer", {noremap = true, silent = true}},
	-- ["<leader>xa"] = {":%bd<CR>", "Close all buffers", {noremap = true, silent = true}},
	-- ["<leader>xo"] = {":%bd|e#|bd#<CR>", "Close other buffers", {noremap = true, silent = true}},
	["<leader>ol"] = { "<CMD>Lazy<CR>", "Open Lazy", { silent = true } },
	["<leader>oM"] = { "<CMD>Mason<CR>", "Open Mason", { silent = true } },
	-- INFO: Needs npm install -g clipboard-cli
	-- ["<leader>yf"] = {
	-- 	function()
	-- 		-- TODO: Need to make the path actually relative to root
	-- 		local bufname = vim.api.nvim_buf_get_name(0)
	-- 		vim.cmd("silent! !echo " .. bufname .. " | clipboard")
	-- 		print("Saved buffer's relative path to the clipboard.")
	-- 	end,
	-- 	"Save buffer's relative path to the clipboard.",
	-- 	{ silent = true },
	-- },
	-- ["<leader>yF"] = {
	-- 	function()
	-- 		local bufname = vim.api.nvim_buf_get_name(0)
	-- 		vim.cmd("silent! !echo " .. bufname .. " | clipboard")
	-- 		print("Saved buffer's absolute path in the clipboard.")
	-- 	end,
	-- 	"Save buffer's absolute path in the clipboard.",
	-- 	{ silent = true },
	-- },
	["<leader>op"] = {
		"<cmd>PlantumlOpen<CR>",
		"Open plantuml preview",
		{ silent = true },
	},
	["<leader>xp"] = {
		function()
			local bufname = vim.api.nvim_buf_get_name(0)
			-- Split the path by '/'
			local parts = {}
			for part in string.gmatch(bufname, "([^/]+)") do
				table.insert(parts, part)
			end

			-- Get the last part (the filename without extension)
			local filenameWithoutExtension = parts[#parts]

			-- Extract the filename (without extension) from the last part
			local filename = string.match(filenameWithoutExtension, "([^%.]+)")
			filename = filename .. ".png"
			vim.cmd("silent! PlantumlSave " .. filename)
			print("Saved to file " .. filename)
		end,
		"Export plantuml",
	},
	["<leader>Or"] = {
		"<cmd>OverseerRun<CR>",
		"Overseer run",
		{ silent = true },
	},
	["<leader>oo"] = {
		"<cmd>OverseerToggle<CR>",
		"Open Overseer",
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

M.t = {
	["<Esc>"] = { "<C-\\><C-n>", "Escape terminal" },
}

return M
