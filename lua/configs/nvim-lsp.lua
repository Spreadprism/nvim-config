-- local function pyright_attach(client, bufnr)
--   -- Example: Keybindings for LSP features (optional)
--   local opts = { noremap=true, silent=false }
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', function()
--     print("LOADING BUFFER")
--     local current_buffer = vim.fn.bufname(vim.fn.bufnr(''))
--     print(current_buffer)
--   end, opts)
--   -- More keybindings can be added as needed
-- end

-- local function base_attach(client, bufnr)
--   print("ATTACHING")
-- end

return function()
  require("neoconf").setup({
    -- override any of the default settings here
  })
  local lspconfig = require('lspconfig')

  local neotest_namespace = vim.api.nvim_create_namespace("neotest")
  vim.diagnostic.config({
    update_in_insert=true,
  })

  vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

  local lsp_defaults = lspconfig.util.default_config
  -- Default LSP configs
  -- lsp_defaults.on_attach = vim.tbl_deep_extend('force', lsp_defaults.on_attach, base_attach)
  lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
  )

  -- Language specific configs

  -- lua
  lspconfig.lua_ls.setup {  }
  -- xml
  lspconfig.lemminx.setup {  }

  -- python
  lspconfig.pyright.setup {
    -- on_attach = pyright_attach,
    settings = {
      python = {
        pythonPath = require("utility.python_env_manager").get_python_path(),
        analysis = {
          extraPaths = {vim.fn.getcwd()},
          autoImportCompletions = true,
          indexing = true,
          packageIndexDepths = {
            {
              name = "",
              depth = 3,
            },
          }
        }
      }
    }
  }

  -- rust
  lspconfig.rust_analyzer.setup {
    -- Server-specific settings. See `:help lspconfig-setup`
    settings = {
      ['rust-analyzer'] = {},
    },
  }

  -- dockerfile 
  lspconfig.dockerls.setup { }

  -- java
  -- lspconfig.java_language_server.setup{
  --   cmd = {"java-language-server"}
  -- }

  -- -- bash
  -- lspconfig.bashls.setup{
  --   settings = {
  --     {
  --       bashIde = {
  --         globPattern = "!(*.env|*@(.sh|.inc|.bash|.command))"
  --       }
  --     }
  --   }
  -- }

  -- go
  local util = require "lspconfig/util"
  lspconfig.gopls.setup {
    cmd={"gopls"},
    filetypes={ "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git")
  }
  -- mojo
  lspconfig.mojo.setup {
    cmd = { 'mojo-lsp-server' },
    filetypes = { 'mojo' },
    single_file_support = true,
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by "c-x"<c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, opts)

      vim.keymap.set({ 'n', 'v' }, "<C-n>", vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })
  -- Setting up auto complete
  vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  local select_opts = {behavior = cmp.SelectBehavior.Select}

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    sources = {
      {name = 'path'},
      {name = 'nvim_lsp', keyword_length = 1},
      {name = 'buffer', keyword_length = 3},
      {name = 'luasnip', keyword_length = 2},
    },
    window = {
      documentation = cmp.config.window.bordered()
    },
    formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
        local menu_icon = {
          nvim_lsp = 'λ',
          luasnip = '⋗',
          buffer = 'Ω',
          path = '🖫',
        }

        item.menu = menu_icon[entry.source.name]
        return item
      end,
    },
    mapping = {
      ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
      ['<Down>'] = cmp.mapping.select_next_item(select_opts),

      ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
      ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),

      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm({select = true}),
      ['<CR>'] = cmp.mapping.confirm({select = false}),

      ['<C-f>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, {'i', 's'}),

      ['<C-b>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {'i', 's'}),

      ['<Tab>'] = cmp.mapping(function(fallback)
        local col = vim.fn.col('.') - 1

        if cmp.visible() then
          cmp.select_next_item(select_opts)
        elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
          fallback()
        else
          cmp.complete()
        end
      end, {'i', 's'}),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item(select_opts)
        else
          fallback()
        end
      end, {'i', 's'}),
    },
  })
end
