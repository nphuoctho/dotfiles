return {
  { "catppuccin/nvim", enabled = false },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
    },
  },
  -- Configure LazyVim to load the colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
