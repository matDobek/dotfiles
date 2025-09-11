-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    -- -----------------------------
    -- Treesitter
    -- -----------------------------
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- -----------------------------
    -- LSP Support
    -- -----------------------------
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    -- -----------------------------
    -- Autocompletion
    -- -----------------------------
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },

    -- -----------------------------
    -- Snippets
    -- -----------------------------
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },

    { ({ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } }) },

    { "windwp/nvim-ts-autotag" },
    { "godlygeek/tabular" },
    { "terrortylor/nvim-comment" },
    { "mg979/vim-visual-multi" },
    { "simrat39/symbols-outline.nvim" },
    {"nvim-telescope/telescope.nvim", dependencies = { "BurntSushi/ripgrep" } },
    { "nvim-lua/plenary.nvim" },  -- used by so many plugins, decided to pull it out for clarity

    { "nvimdev/guard.nvim" },
    { "nvimdev/guard-collection" },

    -- -----------------------------
    -- AI Agents
    -- -----------------------------
    { "johnseth97/codex.nvim" },
    {
      "olimorris/codecompanion.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      opts = {
        -- NOTE: The log_level is in `opts.opts`
        opts = {
          log_level = "DEBUG", -- or "TRACE"
        },
      },
    },

    -- -----------------------------
    -- Maybe / Later
    -- -----------------------------
    { "folke/neodev.nvim" },

    -- https://github.com/nvim-neotest/neotest - interacting with tests
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
