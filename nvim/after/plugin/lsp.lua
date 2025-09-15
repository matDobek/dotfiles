-- ----------------------------
-- -- MASON
-- ----------------------------

local lspconfig = require("lspconfig")

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    'marksman', 'lua_ls', 'sqlls', 'bashls', 'ruby_lsp',
    'jedi_language_server', 'elixirls', 'gopls', 'rust_analyzer',
    'ts_ls', 'svelte', 'cssls',
  },
  handlers = {
    function(server)
      lspconfig[server].setup({})
    end,
  },
}

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
    'css',
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
