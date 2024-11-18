-- ----------------------------
-- -- MASON
-- ----------------------------

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    --
    -- This plugin uses lspconfig server names, not mason ones
    -- ref: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    --
    'marksman', -- markdown
    'lua_ls',
    'sqlls',
    'bashls',

    'ruby_lsp',
    'pyright',
    'elixirls',
    'gopls',
    'rust_analyzer',

    'ts_ls',
    'svelte',
  },
}

-- ----------------------------
-- -- Debugger
-- ----------------------------

-- require("mason-nvim-dap").setup({
--     ensure_installed = { "delve" }
-- })
-- -- require('dap-go').setup()
-- require("dapui").setup()
-- require("nvim-dap-virtual-text").setup()
--
-- local dap = require('dap')
-- -- ref https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
-- dap.adapters.delve = {
--   type = 'server',
--   port = '${port}',
--   executable = {
--     command = 'dlv',
--     args = {'dap', '-l', '127.0.0.1:${port}'},
--   }
-- }
--
-- dap.configurations.go = {
--   {
--     type = "delve",
--     name = "Debug",
--     request = "launch",
--     program = "${file}"
--   },
--   {
--     type = "delve",
--     name = "Debug test",
--     request = "launch",
--     mode = "test",
--     program = "${file}"
--   },
--   -- works with go.mod packages and sub packages
--   {
--     type = "delve",
--     name = "Debug test (go.mod)",
--     request = "launch",
--     mode = "test",
--     program = "./${relativeFileDirname}"
--   }
-- }
--
-- -- require("neodev").setup({
-- --   library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
-- -- })
--
-- -- open/close dapui on entering/exiting debugging
-- local dapui = require("dapui")
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end
--
-- vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end) -- (b)reakpoint
-- vim.keymap.set('n', '<leader>ds', function() require('dap').continue() end)          -- (s)tart
-- vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)          -- (c)ontinue
-- vim.keymap.set('n', '<leader>dd', function() require('dap').step_over() end)         --
-- vim.keymap.set('n', '<leader>df', function() require('dap').step_into() end)
-- vim.keymap.set('n', '<leader>dg', function() require('dap').step_out() end)
-- -- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
-- -- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
-- vim.keymap.set({'n', 'v'}, '<Leader>duh', function()
--   require('dap.ui.widgets').hover()
-- end)
-- vim.keymap.set({'n', 'v'}, '<Leader>dup', function()
--   require('dap.ui.widgets').preview()
-- end)
-- vim.keymap.set('n', '<Leader>duf', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set('n', '<Leader>dus', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.scopes)
-- end)

-- ----------------------------
-- -- TREESITTER
-- ----------------------------

require'nvim-treesitter.configs'.setup {
  -- ref: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
  ensure_installed = {
    'sql',
    'bash',
    'html',
    'javascript',
    'typescript',
    'svelte',
    'lua',
    'ruby',
    'python',
    'elixir',
    'go',
    'rust',
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
}

-- ----------------------------
-- -- CMP
-- ----------------------------

local cmp = require'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local ls = require("luasnip")
require('luasnip.loaders.from_vscode').lazy_load()

-- local opts = { buffer = bufnr, remap = false }
local opts = {}

-- definitions
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.hover() end, opts)
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

-- diagnostics
vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

-- snippets
-- vim.keymap.set({"i", "s"}, "<Tab>", function()
--   if ls.jumpable(1) then
-- 		ls.jump(1)
--   else
--     vim.api.nvim_feedkeys("\t", "n", true)
--     -- vim.api.nvim_feedkeys("\t", "xn", true)
-- 	end
-- end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<S-Tab>", function()
--   if ls.jumpable(-1) then
-- 		ls.jump(-1)
--   else
--     -- noop
-- 	end
-- end, {silent = true})
--
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- Completion
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['Tab'] = cmp.mapping(function(fallback)
      if ls.jumpable(1) then
        ls.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),
    ['S-Tab'] = cmp.mapping(function(fallback)
      if ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),
    -- ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    -- ['<Tab>'] = nil,
    -- ['<S-Tab>'] = nil,
    -- ['<C-Space>'] = cmp.mapping.complete(),
    -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({
    --   reason = cmp.ContextReason.Auto,
    -- }), { "i", "c" }),

    -- Navigate between snippet placeholder
    -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  sources = cmp.config.sources({
    { name = "codeium" },
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'vsnip' }, -- For vsnip users.
    },
  {
    { name = 'buffer' },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "abbr", "kind" },
    format = function(entry, vim_item)
      vim_item.abbr = vim_item.abbr:match("[^(]+")
      -- vim_item.kind = ""

      -- it appears that there is still space reserved for `menu`
      -- despite it being not present in the fields
      vim_item.menu = ""

      return vim_item
    end
  },
})

--
-- Diagnostics
--

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
})

--
-- Setup autocompletion commandline, and search
--

-- -- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
      { name = 'buffer' },
    })
})
--
-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    })
})

--
-- Set configuration for specific filetype.
--

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = {'vim'} } -- prevent "global 'vim' undefined" warning
    }
  }
}

require("lspconfig").bashls.setup {
  capabilities = capabilities,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)"
    }
  }
}

require("lspconfig").marksman.setup { capabilities = capabilities }
require("lspconfig").sqlls.setup { capabilities = capabilities }

require("lspconfig").ruby_lsp.setup { capabilities = capabilities }
require("lspconfig").pyright.setup { capabilities = capabilities }
require("lspconfig").elixirls.setup { capabilities = capabilities }
require("lspconfig").gopls.setup { capabilities = capabilities }
require("lspconfig").rust_analyzer.setup { capabilities = capabilities }

require'lspconfig'.ts_ls.setup{ capabilities = capabilities }
require("lspconfig").svelte.setup { capabilities = capabilities }
