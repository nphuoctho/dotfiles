return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vimdoc",
        "yaml",
        "sql",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("mdx", "markdown")

      -- TSX
      vim.filetype.add({
        extension = {
          tsx = "typescriptreact",
        },
      })
      vim.treesitter.language.register("typescriptreact", "tsx")
    end,
  },
}
