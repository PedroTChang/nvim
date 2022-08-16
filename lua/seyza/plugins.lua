local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  -- snapshot = "july-24",
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Plugin Mangager
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Lua Development
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "RRethy/vim-illuminate"
  use "lvimuser/lsp-inlayhints.nvim"
  use "glepnir/lspsaga.nvim"
  use "onsails/lspkind-nvim"

-- Completion
  use "christianchiarulli/nvim-cmp"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua"

  -- Snippet
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Syntax/Treesitter
  use "nvim-treesitter/nvim-treesitter"
  use "windwp/nvim-ts-autotag"

  -- Marks
  -- use "christianchiarulli/harpoon"

  -- Fuzzy Finder/Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"

  -- Color
  use "NvChad/nvim-colorizer.lua"
  use "ziontee113/color-picker.nvim"

  -- Colorschemes
  use "folke/tokyonight.nvim"
  use "lunarvim/colorschemes"

  -- Utility
  use "rcarriga/nvim-notify"
  use "moll/vim-bbye"
  use "lewis6991/impatient.nvim"

  -- Icon
  use "kyazdani42/nvim-web-devicons"

  -- Debugging
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  -- use "Pocco81/DAPInstall.nvim"

  -- Tabline
  use "akinsho/bufferline.nvim"
  -- use "tiagovla/scope.nvim"

  -- Statusline
  use "christianchiarulli/lualine.nvim"

  -- Startup
  use "goolord/alpha-nvim"

  -- Indent
  use "lukas-reineke/indent-blankline.nvim"

  -- File Explorer
  use "kyazdani42/nvim-tree.lua"

  -- Comment
  use "numToStr/Comment.nvim"

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- Project
  use "ahmedkhalf/project.nvim"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "kdheepak/lazygit.nvim"
  -- Github
  -- use "pwntester/octo.nvim"

  -- Editing Support
  use "windwp/nvim-autopairs"

  -- Keybinding
  use "folke/which-key.nvim"

  -- Markdown
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
