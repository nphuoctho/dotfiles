return {
  {
    "catppuccin/nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
  },
}
