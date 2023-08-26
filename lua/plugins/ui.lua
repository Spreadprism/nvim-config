return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local icons = require("lazyvim.config").icons
            local Util = require("lazyvim.util")
            return {
                options = {
                  theme = "auto",
                  globalstatus = true,
                  disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                          "diagnostics",
                          symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                          },
                        },
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                        -- stylua: ignore
                        {
                          function() return require("nvim-navic").get_location() end,
                          cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
                        },
                      },
                },
            }
        end
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
        }
      }
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
      "akinsho/bufferline.nvim",
      event = "VeryLazy",
      dependencies = "nvim-tree/nvim-web-devicons",
      opts = {
        options = {
          separator_style = "slant",
          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      },
    },
    {
      "SmiteshP/nvim-navic",
      lazy = true,
      init = function()
        vim.g.navic_silence = true
        require("lazyvim.util").on_attach(function(client, buffer)
          if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, buffer)
          end
        end)
      end,
      opts = function()
        return {
          separator = " ",
          highlight = true,
          depth_limit = 5,
          icons = require("lazyvim.config").icons.kinds,
        }
      end,
    }
}