return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        keys = require "keys.neo-tree",
        config = require "configs.neo-tree"
    },
    {
      'echasnovski/mini.indentscope',
      version = '*',
      config = function ()
        require('mini.indentscope').setup({})
      end
    },
    {
      "echasnovski/mini.surround",
      version = "*",
      config = function ()
        require('mini.surround').setup({})
      end
    },
    {
      "jiangmiao/auto-pairs"
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
          plugins = { spelling = true },
          defaults = {
            mode = { "n", "v" },
            ["g"] = { name = "+goto" },
            ["gz"] = { name = "+surround" },
            ["]"] = { name = "+next" },
            ["["] = { name = "+prev" },
            ["<leader><tab>"] = { name = "+tabs" },
            ["<leader>b"] = { name = "+buffer" },
            ["<leader>c"] = { name = "+code" },
            ["<leader>f"] = { name = "+file/find" },
            ["<leader>g"] = { name = "+git" },
            ["<leader>gh"] = { name = "+hunks" },
            ["<leader>q"] = { name = "+quit/session" },
            ["<leader>s"] = { name = "+search" },
            ["<leader>u"] = { name = "+ui" },
            ["<leader>w"] = { name = "+windows" },
            ["<leader>x"] = { name = "+diagnostics/quickfix" },
          },
        },
        config = function(_, opts)
          local wk = require("which-key")
          wk.setup(opts)
          wk.register(opts.defaults)
        end,
      }
}