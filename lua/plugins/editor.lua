return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = require "configs.neo-tree",
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
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>sf', builtin.find_files, {desc="Find files"})
      vim.keymap.set('n', '<leader>scf', builtin.current_buffer_fuzzy_find, {desc="Search current buffer"})
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, {desc="Live grep"})
      vim.keymap.set('n', '<leader>se', builtin.diagnostics, {desc="Search errors"})
      vim.keymap.set('n', '<leader>sd', builtin.lsp_definitions, {desc="Search definition"})
      vim.keymap.set('n', '<leader>si', builtin.lsp_implementations, {desc="Search definition"})
      vim.keymap.set('n', '<leader>sr', builtin.lsp_references, {desc="Search reference"})
      vim.keymap.set('n', '<leader>sb', builtin.buffers, {desc="Search buffer"})

      local trouble = require("trouble.providers.telescope") 
      require('telescope').setup {
        file_ignore_patterns = { "%.env" },
        defaults = {
          mappings = {
            i = {
              ["<Tab>"] = require("telescope.actions").move_selection_next,
              ["<S-Tab>"] = require("telescope.actions").move_selection_previous,
              ["<C-q>"] = require("telescope.actions").close,
              ["<c-t>"] = trouble.open_with_trouble
            },
          }
        }
      }
    end
  },
  { 
    "ellisonleao/dotenv.nvim",
    config = function()
      require('dotenv').setup()
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      }
    },
    config = function()

    end
  }
}
