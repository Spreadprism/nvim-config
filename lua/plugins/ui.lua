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
          lualine_a = require "configs.lualine.lualine_a",
          lualine_b = require "configs.lualine.lualine_b",
          lualine_c = require "configs.lualine.lualine_c",
          lualine_x = require "configs.lualine.lualine_x",
          lualine_y = require "configs.lualine.lualine_y",
          lualine_z = require "configs.lualine.lualine_z",
        }
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
  {
    "norcalli/nvim-colorizer.lua",
    config = function ()
      require("colorizer").setup()
    end
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function ()
      require("nvim-web-devicons").setup({
        strict = true;
        override_by_filename = {
          ["go.mod"] = {
            icon = "󰟓",
            color = "#EF3D7B",
            name = "gomod"
          },
          ["go.sum"] = {
            icon = "󰟓",
            color = "#EF3D7B",
            name = "gosum"
          },
          [".env"] = {
            icon = "",
            color = "#F5BB33",
            name = "env"
          },
        },
        override_by_extension = {
          ["go"] = {
            icon = "󰟓",
            color = "#29BEB0",
            name = "go"
          },
          ["mojo"] = {
            icon = "󰈸",
            color = "#FF6723",
            name = "mojo"
          },
          ["env"] = {
            icon = "",
            color = "#F5BB33",
            name = "env"
          },
          ["code-workspace"] = {
            icon = "󰨞",
            color = "#23AAF2",
            name = "codeworkspace"
          },
          ["rs"] = {
            icon = "",
            color = "#FF7047",
            name = "rs"
          },
          ["bin"] = {
            icon = "",
            color = "#9D9D9D",
            name = "bin"
          },
        },
      })
    end
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          if level:match("error") then
            return " "
          end
          return ""
        end,
        numbers = "ordinal",
        separator_style = "slant",
        modified_icon = "󱇧",
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
}
