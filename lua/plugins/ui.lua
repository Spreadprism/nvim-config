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
  { "nvim-tree/nvim-web-devicons", lazy = true },
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
  {
    "NvChad/nvterm",
    config = function ()
      require("nvterm").setup()
    end,
  }
}
