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
        ["<leader>sc"] = { name = "+current buffer" },
        ["<leader>sh"] = { name = "+history" },
        ["<leader>sg"] = { name = "+git" },
        ["<leader>sgb"] = { name = "+current buffer" },
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
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local builtin = require('telescope.builtin')
      -- INFO: general
      vim.keymap.set('n', '<leader>sb', builtin.buffers, {desc="Search buffer"})
      vim.keymap.set('n', '<leader>sC', builtin.commands, {desc="Search commands"})
      -- INFO: history
      vim.keymap.set('n', '<leader>shC', builtin.command_history, {desc="Search commands history"})
      -- INFO: git
      vim.keymap.set('n', '<leader>sgB', builtin.git_branches, {desc="Search branches"})
      vim.keymap.set('n', '<leader>sgc', builtin.git_commits, {desc="Search commits"})
      vim.keymap.set('n', '<leader>sgbc', builtin.git_bcommits, {desc="Search commits"})
      vim.keymap.set('v', '<leader>sgbc', builtin.git_bcommits_range, {desc="Search commits"})
      -- INFO: lsp
      vim.keymap.set('n', '<leader>se', builtin.diagnostics, {desc="Search errors"})
      vim.keymap.set('n', '<leader>sd', builtin.lsp_definitions, {desc="Search definition"})
      vim.keymap.set('n', '<leader>si', builtin.lsp_implementations, {desc="Search definition"})
      vim.keymap.set('n', '<leader>sr', builtin.lsp_references, {desc="Search reference"})
      -- INFO: files
      vim.keymap.set('n', '<leader>sf', builtin.find_files, {desc="Search files"})
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, {desc="Grep workspace"})
      -- INFO: current file
      vim.keymap.set('n', '<leader>scf', builtin.current_buffer_fuzzy_find, {desc="Fuzzy finder"})
      vim.keymap.set('n', '<leader>sce', function () require('telescope.builtin').diagnostics{bufnr=0} end, {desc="Search errors"})

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
    "nvim-lua/plenary.nvim"
  },
  {
    "folke/todo-comments.nvim",
    lazy=false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
      require("todo-comments").setup({})

      vim.keymap.set('n', '<leader>st', "<cmd>TodoTelescope keywords=TODO<CR>", {desc="Search TODO"})
      vim.keymap.set('n', '<leader>s#', "<cmd>TodoTelescope<CR>", {desc="Find tags"})

    end
    -- PERF: test perf?  
    -- HACK: bruh
    -- TODO: wew
    -- NOTE:  sdkfj dkfjskdfj 
    -- FIX: fixed 
    -- WARNING: test done
  }
}
