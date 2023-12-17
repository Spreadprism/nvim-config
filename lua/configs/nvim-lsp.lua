return function()
	require("neoconf").setup({
		-- override any of the default settings here
	})
	local lspconfig = require("lspconfig")

	vim.diagnostic.config({
		update_in_insert = true,
	})

	vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])

	local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Language specific configs

	local util = require("lspconfig/util")
	-- lua
	lspconfig.lua_ls.setup({
		settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
			},
		},
	})
	-- xml
	lspconfig.lemminx.setup({})
	-- python

	local rules_to_ignore = {
		"E999",
	}
	lspconfig.ruff_lsp.setup({
		on_attach = function(client, _)
			client.server_capabilities.hoverProvider = false
		end,
		init_options = {
			settings = {
				-- Any extra CLI arguments for `ruff` go here.
				args = {
					-- "--ignore",
					-- table.concat(rules_to_ignore, ","),
				},
			},
		},
	})

	lspconfig.pyright.setup({
		capabilities = lsp_capabilities,
		settings = {
			python = {
				pythonPath = require("utility.python_env_manager").get_python_path(),
				reportUnusedImport = "warning",
				analysis = {
					extraPaths = { vim.fn.getcwd() },
					autoImportCompletions = true,
					indexing = true,
					packageIndexDepths = {
						{
							name = "",
							depth = 3,
						},
					},
					diagnosticSeverityOverrides = {
						reportUnusedImport = "false",
						reportUnusedClass = "false",
						reportUnusedFunction = "false",
						reportUnusedVariable = "false",
					},
				},
			},
		},
	})

	function filter(arr, func)
		-- Filter in place
		-- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
		local new_index = 1
		local size_orig = #arr
		for old_index, v in ipairs(arr) do
			if func(v, old_index) then
				arr[new_index] = v
				new_index = new_index + 1
			end
		end
		for i = new_index, size_orig do
			arr[i] = nil
		end
	end

	function filter_diagnostics(diagnostic)
		-- Only filter out Pyright stuff for now
		if diagnostic.source ~= "Pyright" then
			return true
		end

		-- remove any diagnostic messages that end with is not accessed

		if diagnostic.message:find("is not accessed") then
			return false
		end
		-- if diagnostic.message == '"kwargs" is not accessed' then
		-- 	return false
		-- end
		--
		-- -- Allow variables starting with an underscore
		-- if string.match(diagnostic.message, '"_.+" is not accessed') then
		-- 	return false
		-- end

		return true
	end

	function custom_on_publish_diagnostics(a, params, client_id, c, config)
		filter(params.diagnostics, filter_diagnostics)
		vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
	end

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {})

	lspconfig.tsserver.setup({
		filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
		cmd = { "typescript-language-server", "--stdio" },
	})
	-- rust
	-- lspconfig.rust_analyzer.setup({
	-- 	filetypes = { "rust" },
	-- 	root_dir = util.root_pattern("Cargo.toml"),
	-- 	-- Server-specific settings. See `:help lspconfig-setup`
	-- 	settings = {
	-- 		["rust-analyzer"] = {
	-- 			cargo = {
	-- 				allFeatures = true,
	-- 			},
	-- 		},
	-- 	},
	-- })

	-- dockerfile
	lspconfig.dockerls.setup({})

	-- java
	-- lspconfig.java_language_server.setup{
	--   cmd = {"java-language-server"}
	-- }

	-- -- bash
	-- vim.treesitter.language.register("env", "bash")
	-- local group = vim.api.nvim_create_augroup("__env", { clear = true })
	-- vim.api.nvim_create_autocmd("BufEnter", {
	-- 	pattern = "**/*.env",
	-- 	group = group,
	-- 	callback = function(args)
	-- 		vim.cmd("set filetype=env")
	-- 		local clients = vim.lsp.buf_get_clients(bufnr)
	--
	-- 		for i, client in pairs(clients) do
	-- 			vim.cmd("LspStop " .. i)
	-- 		end
	-- 		-- vim.diagnostic.disable(args.buf)
	-- 	end,
	-- })

	lspconfig.bashls.setup({
		settings = {
			{
				root_dir = vim.fn.getcwd(),
				bashIde = {
					globPattern = "!(*.env|*@(.sh|.inc|.bash|.command))",
				},
			},
		},
	})

	-- go
	lspconfig.gopls.setup({
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	})
	-- mojo
	lspconfig.mojo.setup({
		cmd = { "mojo-lsp-server" },
		filetypes = { "mojo" },
		single_file_support = true,
	})

	-- c#
	local home = os.getenv("HOME")
	lspconfig.omnisharp.setup({
		cmd = { home .. "/.local/share/nvim/mason/bin/omnisharp" },
	})

	-- c
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.offsetEncoding = { "utf-16" }

	lspconfig.clangd.setup({
		capabilities = capabilities,
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			-- Enable completion triggered by "c-x"<c-o>
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<f2>", vim.lsp.buf.rename, opts)

			vim.keymap.set({ "n", "v" }, "<C-n>", vim.lsp.buf.code_action, opts)
			-- vim.keymap.set("n", "<space>f", function()
			-- 	vim.lsp.buf.format({ async = true })
			-- end, opts)
		end,
	})
end
