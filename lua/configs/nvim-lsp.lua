local function filter(arr, func)
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

local pyright_accessed_filter = function(diagnostic)
	-- Allow kwargs to be unused, sometimes you want many functions to take the
	-- same arguments but you don't use all the arguments in all the functions,
	-- so kwargs is used to suck up all the extras
	-- if diagnostic.message == '"kwargs" is not accessed' then
	-- 	return false
	-- end
	--
	-- Allow variables starting with an underscore
	-- if string.match(diagnostic.message, '"_.+" is not accessed') then
	-- 	return false
	-- end

	-- For all messages "is not accessed"
	if string.match(diagnostic.message, '".+" is not accessed') then
		return false
	end

	return true
end

local custom_on_publish_diagnostics = function(a, params, client_id, c, config)
	filter(params.diagnostics, pyright_accessed_filter)
	vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
end

local on_attach = function(client, _)
	if client.name == "pyright" then
		vim.keymap.set("n", "<Leader>ao", "<CMD>PyrightOrganizeImports<CR>", { desc = "Organize imports" })
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {})
	end
end

return function()
	require("neoconf").setup({
		-- override any of the default settings here
	})
	local lspconfig = require("lspconfig")

	vim.diagnostic.config({
		update_in_insert = true,
	})

	vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])

	local lsp_defaults = lspconfig.util.default_config
	-- Default LSP configs
	-- lsp_defaults.on_attach = vim.tbl_deep_extend('force', lsp_defaults.on_attach, base_attach)
	lsp_defaults.capabilities =
		vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

	-- Language specific configs

	local util = require("lspconfig/util")
	-- lua
	lspconfig.lua_ls.setup({
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	})
	-- xml
	lspconfig.lemminx.setup({})
	-- python
	lspconfig.pyright.setup({
		on_attach = on_attach,
		settings = {
			python = {
				pythonPath = require("utility.python_env_manager").get_python_path(),
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
						reportUnusedImport = "none",
						reportUnusedClass = "none",
						reportUnusedFunction = "none",
						reportUnusedVariable = "none",
					},
				},
			},
		},
	})

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
