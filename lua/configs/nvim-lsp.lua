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
