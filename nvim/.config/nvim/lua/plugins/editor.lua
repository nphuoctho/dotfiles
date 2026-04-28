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

  -- Auto-close brackets, quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- dùng treesitter để tránh pair trong comments/strings
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
      },
    },
  },

  -- Auto-close và auto-rename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
      "xml",
    },
    opts = {},
  },

  -- Mini Nvim
  { "echasnovski/mini.ai", version = "*", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.comment", version = "*", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.bufremove", version = "*", event = "VeryLazy", opts = {} },
  { "nvim-mini/mini.surround", version = "*", event = "VeryLazy", opts = {} },
  { "nvim-mini/mini.pairs", version = "*", event = "VeryLazy", opts = {} },
}
