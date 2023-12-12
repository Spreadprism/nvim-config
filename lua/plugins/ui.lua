return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",

		opts = function()
			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha" } },
				},
				sections = {
					lualine_a = require("configs.lualine.lualine_a"),
					lualine_b = require("configs.lualine.lualine_b"),
					lualine_c = require("configs.lualine.lualine_c"),
					lualine_x = require("configs.lualine.lualine_x"),
					lualine_y = require("configs.lualine.lualine_y"),
					lualine_z = require("configs.lualine.lualine_z"),
				},
			}
		end,
	},
	{
		"jonahgoldwastaken/copilot-status.nvim",
		event = "VeryLazy",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_status").setup({
				icons = {
					idle = " ",
					error = " ",
					offline = " ",
					warning = " ",
					loading = " ",
				},
				debug = false,
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			views = {
				mini = {
					win_options = {
						winblend = 0,
					},
				},
			},
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup({
				strict = true,
				override_by_filename = require("icons.filename"),
				override_by_extension = require("icons.extension"),
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				render = "compact",
				background_colour = "Normal",
				stages = "slide",
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		config = function()
			require("neoscroll").setup({ stop_eof = false })
		end,
	},
	{
		"kiyoon/jupynium.nvim",
		event = "VeryLazy",
		build = "conda run --no-capture-output -n base pip install .",
		cmd = { "JupyniumStartAndAttachToServer", "JupyniumAttachToServer" },
		config = function()
			require("jupynium").setup({
				-- python_host = { "conda", "run", "--no-capture-output", "-n", "jupynium", "python" },
				python_host = { "conda", "run", "--no-capture-output", "-n", "base", "python" },
				notebook_dir = vim.fn.getcwd(),
				use_default_keybindings = false,
				-- python = "python3",
				-- jupyter_command = "jupyter",
				jupyter_command = { "conda", "run", "--no-capture-output", "-n", "base", "jupyter" },
				-- default_notebook_URL = "localhost:8888/",
				auto_start_server = {
					enable = false,
				},
			})
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
	},
	-- {
	-- 	"3rd/image.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("image").setup({
	-- 			backend = "kitty",
	-- 			integrations = {
	-- 				markdown = {
	-- 					enabled = true,
	-- 					clear_in_insert_mode = false,
	-- 					download_remote_images = true,
	-- 					only_render_image_at_cursor = false,
	-- 					filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
	-- 				},
	-- 				neorg = {
	-- 					enabled = true,
	-- 					clear_in_insert_mode = false,
	-- 					download_remote_images = true,
	-- 					only_render_image_at_cursor = false,
	-- 					filetypes = { "norg" },
	-- 				},
	-- 			},
	-- 			max_width = nil,
	-- 			max_height = nil,
	-- 			max_width_window_percentage = nil,
	-- 			max_height_window_percentage = 50,
	-- 			window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
	-- 			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	-- 			editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
	-- 			tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
	-- 			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
	-- 		})
	-- 	end,
	-- },
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		event = "VeryLazy",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("barbecue").setup({
				create_autocmd = false, -- prevent barbecue from updating itself automatically
			})
			vim.api.nvim_create_autocmd({
				"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
				"BufWinEnter",
				"CursorHold",
				"InsertLeave",

				-- include this if you have set `show_modified` to `true`
				"BufModifiedSet",
			}, {
				group = vim.api.nvim_create_augroup("barbecue.updater", {}),
				callback = function()
					require("barbecue.ui").update()
				end,
			})
		end,
	},
	-- {
	-- 	"Bekaboo/dropbar.nvim",
	-- 	-- optional, but required for fuzzy finder support
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope-fzf-native.nvim",
	-- 	},
	-- },
	-- {
	--   'goolord/alpha-nvim',
	--   dependencies = { 'nvim-tree/nvim-web-devicons' },
	--   config = function ()
	--       require'alpha'.setup(require'configs.dashboard'.config)
	--   end
	-- }
}
