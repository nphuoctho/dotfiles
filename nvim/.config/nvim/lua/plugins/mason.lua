return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  keys = {
    { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
  },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        "lua_ls",
        "cssls",
        "eslint",
        "html",
        "jsonls",
        "ts_ls",
        "pyright",
        "tailwindcss",
        "vue_ls", -- Vue LSP
      },
    })
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "ruff", -- Python linter and formatter
        "eslint_d",
      },
    })
  end,
}
