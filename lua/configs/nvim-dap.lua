return function()
	-- INFO: Setting DAP icons
	vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "󰯲", texthl = "ErrorMsg", linehl = "", numhl = "" })
	vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })

	vim.cmd("highlight DapStoppedSign guifg=#87D285")
	vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedSign", linehl = "DapStoppedSign", numhl = "" })

	local dap = require("dap")

	-- INFO: Adding adapters
	dap.adapters.codelldb = {
		type = "server",
		port = "13000",
		executable = {
			command = "codelldb",
			args = { "--port", "13000" },
		},
	}

	dap.adapters.coreclr = {
		type = "executable",
		command = "netcoredbg",
		args = { "--interpreter=vscode" },
	}

	-- INFO: Load vscode launch.json
	require("dap.ext.vscode").load_launchjs(nil, {
		codelldb = { "rust", "c" },
	})
	-- local mason_bin = os.getenv("HOME") .. "/.local/share/nvim/mason"

	-- INFO: Custom dap configs
	for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
		dap.configurations[language] = {
			{
				-- use nvim-dap-vscode-js's pwa-node debug adapter
				type = "(NVIM-CONFIG) pwa-node",
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
				type = "(NVIM-CONFIG) pwa-node",
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
				name = "(NVIM-CONFIG) Launch chrome debugger (NEXT)",
				type = "pwa-chrome",
				request = "launch",
				url = "http://localhost:3000",
				-- skip files from vite's hmr
				skipFiles = { "**/node_modules/**/*", "**/src/*" },
				resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
				webRoot = "${workspaceFolder}",
				sourceMaps = true,
				port = "9222",
				console = "integratedTerminal",
			},
		}
	end

	-- local get_program = function()
	-- 	return vim.fn.input("program: ", vim.loop.cwd() .. "/" .. vim.fn.expand("%f"), "file")
	-- end
	-- local get_args = function()
	-- 	return vim.split(vim.fn.input("args: ", "", "file"), " ")
	-- end
	--
	-- dap.configurations.c = {
	-- 	{
	-- 		type = "codelldb",
	-- 		request = "launch",
	-- 		cwd = "${workspaceFolder}",
	-- 		terminal = "integrated",
	-- 		console = "integratedTerminal",
	-- 		stopOnEntry = false,
	-- 		program = get_program,
	-- 		args = get_args,
	-- 	},
	-- }
	-- -- dap.configurations.cpp = dap.configurations.c
	--
	local overseer = require("overseer")

	local get_cs_program_debug = function()
		local directory = vim.fn.getcwd()
		local program_name = string.match(directory, "[^/]+$")
		local program = directory .. "/bin/Debug/net7.0/" .. program_name .. ".dll"
		return program
	end

	-- INFO: C# CONFIGS
	overseer.register_template({
		name = "C# build debug",
		builder = function(params)
			return {
				cmd = { "dotnet" },
				args = { "build" },
				name = "C# build debug",
			}
		end,
	})

	dap.configurations.cs = {
		{
			name = "(NVIM-CONFIG) Launch debug",
			type = "coreclr",
			request = "launch",
			cwd = "${workspaceFolder}",
			terminal = "integrated",
			console = "integratedTerminal",
			stopOnEntry = false,
			program = get_cs_program_debug,
			preLaunchTask = "C# build debug",
		},
	}
	-- INFO: RUST CONFIGS

	local get_rust_program_debug = function()
		local directory = vim.fn.getcwd()
		local program_name = string.match(directory, "[^/]+$")
		local program = directory .. "/target/debug/" .. program_name
		return program
	end

	overseer.register_template({
		name = "Rust build debug",
		builder = function(params)
			return {
				cmd = { "cargo" },
				args = { "build" },
				name = "Rust build debug",
			}
		end,
	})

	overseer.register_template({
		name = "rust_build_release",
		builder = function(params)
			return {
				cmd = { "cargo" },
				args = { "build", "--release" },
				name = "rust_build_release",
			}
		end,
	})

	dap.configurations.rust = {
		{
			name = "(NVIM-CONFIG) Launch debug",
			type = "codelldb",
			request = "launch",
			cwd = "${workspaceFolder}",
			terminal = "integrated",
			console = "integratedTerminal",
			stopOnEntry = false,
			program = get_rust_program_debug,
			preLaunchTask = "Rust build debug",
		},
	}

	-- INFO: Load vscode launch.json
	require("dap.ext.vscode").load_launchjs(nil, {
		codelldb = { "rust", "c" },
	})
end
