local M = {}

M.n = {
	["<F5>"] = {
		function()
			-- RustRunnables
			-- local current_bufnr = vim.api.nvim_get_current_buf()
			-- local filetype = vim.api.nvim_buf_get_option(current_bufnr, "filetype")
			-- if filetype == "rust" then
			-- 	local sessions = require("dap").sessions()
			-- 	local sessionActive = false
			-- 	for _, session in pairs(sessions) do
			-- 		if session ~= nil and session.is_active ~= nil and session:is_active() then
			-- 			sessionActive = true
			-- 			break
			-- 		end
			-- 	end
			-- 	if sessionActive then
			-- 		require("dap").continue()
			-- 	else
			-- 		vim.cmd("RustDebuggables")
			-- 	end
			-- else
			require("dap").continue()
			-- end
		end,
		"DAP start / continue",
		{ silent = true },
	},
	["<F10>"] = {
		function()
			require("dap").step_over()
		end,
		"DAP step_over",
		{ silent = true },
	},
	["<F11>"] = {
		function()
			require("dap").step_into()
		end,
		"DAP step_into",
		{ silent = true },
	},
	["<F12>"] = {
		function()
			require("dap").step_out()
		end,
		"DAP step_out",
		{ silent = true },
	},
	["<leader>db"] = {
		function()
			require("dap").toggle_breakpoint()
		end,
		"Toggle breakpoint",
		{ silent = true },
	},
	["<leader>dcb"] = {
		function()
			local condition = vim.fn.input("Condition: ")
			if condition ~= nil and condition ~= "" then
				require("dap").set_breakpoint(condition)
			end
		end,
		"Add conditional breakpoint",
		{ silent = true },
	},
	["<leader>dl"] = {
		function()
			local log_message = vim.fn.input("Log message: ")
			if log_message ~= nil and log_message ~= "" then
				require("dap").set_breakpoint(nil, nil, log_message)
			end
		end,
		"Add log point",
		{ silent = true },
	},
	["<leader>dg"] = {
		function()
			require("dap").run_to_cursor()
		end,
		"Go to cursor",
		{ silent = true },
	},
	["<leader>dr"] = {
		function()
			require("dap").run_last()
		end,
		"Rerun last debug config",
		{ silent = true },
	},
	["<leader>ds"] = {
		function()
			require("dap").terminate()
			require("dapui").close()
		end,
		"Stop debugging session",
		{ silent = true },
	},
	["<leader>do"] = {
		function()
			require("dapui").toggle()
		end,
		"Toggle dapui",
		{ silent = true },
	},
	["<leader>de"] = {
		function()
			require("dapui").eval()
		end,
		"Evaluate under cursor",
		{ silent = true },
	},
	["<leader>dR"] = {
		function()
			require("dapui").float_element("repl", {})
		end,
		"Open repl",
		{ silent = true },
	},
	["<leader>sb"] = {
		function()
			require("telescope").extensions.dap.list_breakpoints()
		end,
		"Search breakpoints",
		{ silent = true },
	},
	["<leader>oc"] = {
		function()
			require("dapui").toggle(3)
		end,
	},
	["<leader>or"] = {
		function()
			require("dapui").toggle(2)
		end,
	},
	["<leader>ow"] = {
		function()
			require("dapui").toggle(1)
		end,
	},
}
return M
