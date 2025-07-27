return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    {
      "mason-org/mason.nvim",
      cmd = "Mason",
      build = ":MasonUpdate",
      keys = {
        { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
      },
      ---@module 'mason'
      ---@type MasonSettings
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        ensure_installed = {
          "stylua",
          "prettier",
          "eslint_d",
          "ruff", -- Python linter and formatter
          "phpcs",
          "php-cs-fixer",
        },
      },
    },
  },
  ---@module 'mason-lspconfig'
  ---@type MasonLspconfigSettings
  opts = {
    ensure_installed = {
      "lua_ls",
      "html",
      "cssls",
      "eslint",
      "ts_ls",
      "tailwindcss",
      "jsonls",
      "volar", -- Vue LSP
      "pyright",
      "intelephense",
    },
  },
}
