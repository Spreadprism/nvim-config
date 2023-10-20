return function()
	vim.g.neo_tree_root_folder = "name"
	require("neo-tree").setup({
		close_if_last_window = true,
		use_popups_for_input = true,
		-- popup_border_style = "rounded",
		filesystem = {
			group_empty_dir = true,
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = false,
				hide_gitignored = false,
			},
		},
		window = {
			mappings = {
				["a"] = {
					"add",
					-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
					-- some commands may take optional config options, see `:h neo-tree-mappings` for details
					config = {
						show_path = "relative", -- "none", "relative", "absolute"
					},
				},
			},
		},
		event_handlers = {
			{
				event = "file_opened",
				handler = function(file_path)
					--auto close
					require("neo-tree").close_all()
				end,
			},
		},
		default_component_configs = {
			indent = {
				indent_size = 2,
				padding = 1,
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = "󱀶",
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "󱇧",
				highlight = "NeoTreeModified",
			},
			name = {
				use_git_status_colors = false,
			},
			git_status = {
				symbols = {
					added = "",
					modified = "",
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
		},
	})
end
