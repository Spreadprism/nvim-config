return function()
	-- INFO: Setting DAP icons
	vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "󰯲", texthl = "ErrorMsg", linehl = "", numhl = "" })
	vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })

	vim.cmd("highlight DapStoppedSign guifg=#87D285")
	vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedSign", linehl = "DapStoppedSign", numhl = "" })

	local dap = require("dap")

	-- local mason_bin = os.getenv("HOME") .. "/.local/share/nvim/mason"

	-- INFO: Custom dap configs
	for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
		dap.configurations[language] = {
			{
				-- use nvim-dap-vscode-js's pwa-node debug adapter
				type = "pwa-node",
				-- launch a new process to attach the debugger to
				request = "launch",
				-- name of the debug action you have to select for this config
				name = "Launch current file in new node process",
				program = "${file}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
			},
			{
				-- use nvim-dap-vscode-js's pwa-node debug adapter
				type = "pwa-node",
				-- attach to an already running node process with --inspect flag
				-- default port: 9222
				request = "attach",
				-- allows us to pick the process using a picker
				processId = require("dap.utils").pick_process,
				-- name of the debug action
				name = "Attach debugger to existing `node --inspect` process",
				-- for compiled languages like TypeScript or Svelte.js
				sourceMaps = true,
				-- resolve source maps in nested locations while ignoring node_modules
				resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
				-- path to src in vite based projects (and most other projects as well)
				cwd = "${workspaceFolder}/src",
				-- we don't want to debug code inside node_modules, so skip it!
				skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
			},
			{
				name = "Launch chrome debugger (NEXT)",
				type = "pwa-chrome",
				request = "launch",
				url = "http://localhost:3000",
				-- skip files from vite's hmr
				skipFiles = { "**/node_modules/**/*", "**/src/*" },
				webRoot = "${workspaceFolder}",
				port = "9222",
				console = "integratedTerminal",
			},
		}
	end

	-- INFO: Load vscode launch.json
	require("dap.ext.vscode").load_launchjs(nil, {})
end
