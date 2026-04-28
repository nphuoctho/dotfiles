---@type LazySpec
return {
  {
    "romus204/tree-sitter-manager.nvim",
    config = function()
      require("tree-sitter-manager").setup {
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          -- Web
          "html",
          "css",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "jsonc",
          -- Python
          "python",
          -- C/C++
          "c",
          "cpp",
          -- Misc
          "bash",
          "markdown",
          "markdown_inline",
          "yaml",
          "toml",
        },
        border = "rounded",
        auto_install = true,
        highlight = true,
      }
    end,
  },

  -- Mini Nvim
  { "echasnovski/mini.ai", version = "*", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.comment", version = "*", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.bufremove", version = "*", event = "VeryLazy", opts = {} },
  { "nvim-mini/mini.surround", version = "*", event = "VeryLazy", opts = {} },
  { "nvim-mini/mini.pairs", version = "*", event = "VeryLazy", opts = {} },
}
