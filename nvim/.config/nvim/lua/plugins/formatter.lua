local util = require("conform.util")

return {
  "stevearc/conform.nvim",
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      python = { "ruff_format" },
      php = { "pint" },
    },
    -- Custom formatter for ruff
    formatters = {
      ruff_format = {
        command = "ruff",
        args = { "format", "--stdin-filename", "$FILENAME", "-" },
        stdin = true,
      },
      pint = {
        command = "pint",
        args = { "$FILENAME" },
        stdin = false,
        cwd = util.root_file({ "pint.json", "composer.json" }),
        env = {
          PATH = os.getenv("HOME") .. "/.config/composer/vendor/bin:" .. os.getenv("PATH"),
        },
      },
    },
  },
}
