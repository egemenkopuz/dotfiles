local M = {}

M = {
  ["wbthomason/packer.nvim"] = {},

  ["nvim-lua/plenary.nvim"] = { module = "plenary" },

  ["lewis6991/impatient.nvim"] = {},

  ["kyazdani42/nvim-web-devicons"] = {
    module = "nvim-web-devicons",
    config = function()
      require("user.plugins.configs.webdevicons").setup()
    end,
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    setup = function()
      require("user.utils").lazy.on_file_open "indent-blankline.nvim"
    end,
    config = function()
      require("user.plugins.configs.blankline").setup()
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    module = "nvim-treesitter",
    setup = function()
      require("user.utils").lazy.on_file_open "nvim-treesitter"
    end,
    cmds = require("user.plugins.configs.treesitter").lazy_commands,
    run = ":TSUpdate",
    config = function()
      require("user.plugins.configs.treesitter").setup()
    end,
  },

  ["lewis6991/gitsigns.nvim"] = {
    ft = "gitcommit",
    setup = function()
      require("user.plugins.configs.gitsigns").lazy_laod()
      require("user.utils").keys.load_section "gitsigns"
    end,
    config = function()
      require("user.plugins.configs.gitsigns").setup()
    end,
  },

  ["williamboman/mason.nvim"] = {
    cmd = require("user.plugins.configs.mason").lazy_commands,
    config = function()
      require("user.plugins.configs.mason").setup()
    end,
  },

  ["neovim/nvim-lspconfig"] = {
    opt = true,
    setup = function()
      require("user.utils").lazy.on_file_open "nvim-lspconfig"
    end,
    config = function()
      require("user.plugins.configs.lspconfig").setup()
    end,
  },

  ["rafamadriz/friendly-snippets"] = {
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  },

  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    config = function()
      require("user.plugins.configs.cmp").setup()
    end,
  },

  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("user.plugins.configs.luasnip").setup()
    end,
  },

  ["saadparwaiz1/cmp_luasnip"] = { after = "LuaSnip" },

  ["hrsh7th/cmp-nvim-lua"] = { after = "cmp_luasnip" },

  ["hrsh7th/cmp-nvim-lsp"] = { after = "cmp-nvim-lua" },

  ["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lsp" },

  ["hrsh7th/cmp-path"] = { after = "cmp-buffer" },

  ["kyazdani42/nvim-tree.lua"] = {
    cmd = require("user.plugins.configs.nvimtree").lazy_commands,
    tag = "nightly",
    config = function()
      require("user.plugins.configs.nvimtree").setup()
    end,
    setup = function()
      require("user.utils").keys.load_section "nvimtree"
    end,
  },

  ["smjonas/inc-rename.nvim"] = {
    config = function()
      require("inc_rename").setup()
    end,
    setup = function()
      require("user.utils").keys.load_section "rename"
    end,
  },

  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = function()
      require("user.plugins.configs.autopairs").setup()
    end,
  },

  ["goolord/alpha-nvim"] = {
    config = function()
      require("user.plugins.configs.alpha").setup()
    end,
  },

  ["numToStr/Comment.nvim"] = {
    module = "Comment",
    keys = { "gc", "gb" },
    config = function()
      require("user.plugins.configs.comment").setup()
    end,
    setup = function()
      require("user.utils").keys.load_section "comment"
    end,
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    config = function()
      require("user.plugins.configs.null_ls").setup()
    end,
  },

  -- ["wbthomason/packer.nvim"] = {},
  ["arkav/lualine-lsp-progress"] = {},

  ["sindrets/diffview.nvim"] = {
    cmd = require("user.plugins.configs.diffview").lazy_commands,
    config = function()
      require("user.plugins.configs.diffview").setup()
    end,
  },
  ["ray-x/lsp_signature.nvim"] = {
    config = function()
      require("user.plugins.configs.signature").setup()
    end,
  },

  ["folke/trouble.nvim"] = {
    config = function()
      require("user.plugins.configs.trouble").setup()
    end,
    setup = function()
      require("user.utils").keys.load_section "trouble"
    end,
  },
  ["karb94/neoscroll.nvim"] = {
    config = function()
      require("user.plugins.configs.neoscroll").setup()
    end,
  },

  ["RRethy/vim-illuminate"] = {
    config = function()
      require("user.plugins.configs.illuminate").setup()
    end,
  },

  ["ahmedkhalf/project.nvim"] = {
    config = function()
      require("project_nvim").setup()
    end,
  },

  ["olimorris/persisted.nvim"] = {
    config = function()
      require("user.plugins.configs.persisted").setup()
    end,
  },

  ["nvim-telescope/telescope.nvim"] = {
    cmd = "Telescope",
    config = function()
      require("user.plugins.configs.telescope").setup()
    end,
    setup = function()
      require("user.utils").keys.load_section "telescope"
    end,
  },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    run = "make",
  },
  ["phaazon/hop.nvim"] = {
    branch = "v2",
    config = function()
      require("user.plugins.configs.hop").setup()
    end,
  },
  ["akinsho/toggleterm.nvim"] = {
    tag = "*",
    config = function()
      require("user.plugins.configs.toggleterm").setup()
    end,
    setup = function()
      require("user.utils").keys.load_section "toggleterm"
    end,
  },

  ["akinsho/bufferline.nvim"] = {
    tag = "v2.*",
    event = "BufWinEnter",
    config = function()
      require("user.plugins.configs.bufferline").setup()
    end,
    setup = function()
      require("user.utils").keys.load_section "bufferline"
    end,
  },

  ["nvim-lualine/lualine.nvim"] = {
    event = "VimEnter",
    config = function()
      require("user.plugins.configs.lualine").setup()
    end,
  },

  -- ["sam4llis/nvim-tundra"] = {
  --   config = function()
  --     require("user.plugins.configs.theme").setup()
  --   end,
  -- },

  ["catppuccin/nvim"] = {
    config = function()
      require("user.plugins.configs.theme").setup()
    end,
  },
}

return M
