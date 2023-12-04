-- Auto install pakcer.nvim
local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
end

vim.cmd.packadd("packer.nvim")

require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  -- LSP Support
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use "williamboman/mason-lspconfig.nvim"

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  -- use 'hrsh7th/cmp-vsnip'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'hrsh7th/vim-vsnip-integ'

  use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } })
  use {
	  "nvim-telescope/telescope.nvim", tag = "0.1.4",
	  -- or                            , branch = "0.1.x",
	  requires = { {"nvim-lua/plenary.nvim"} }
  }

  use 'jiangmiao/auto-pairs'
  use "godlygeek/tabular"
  use "terrortylor/nvim-comment"
  use "airblade/vim-gitgutter"
  use "mg979/vim-visual-multi"
  use "ggandor/leap.nvim"

  use "fatih/vim-go"

  -- ai stuff
  use {
    "Exafunction/codeium.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    }
  }

  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })

  -- use("github/copilot.vim")
  -- use("aduros/ai.vim")
  -- use("nvim-lualine/lualine.nvim")
  -- use("folke/zen-mode.nvim")

  -- themes
  use("cideM/yui")
  use("bcicen/vim-vice")
  use("folke/tokyonight.nvim")
  use("nikolvs/vim-sunbather")
  use({"rose-pine/neovim", as = "rose-pine" })
  use "rebelot/kanagawa.nvim"
  use "NLKNguyen/papercolor-theme"
  use { "ellisonleao/gruvbox.nvim" }

end)
