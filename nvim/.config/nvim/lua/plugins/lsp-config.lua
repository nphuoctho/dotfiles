return {
  -- Mason: Quản lý cài đặt công cụ
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua", -- Formatter cho Lua
        "lua-language-server",
        "shellcheck", -- Linter cho shell scripts
        "shfmt", -- Formatter cho shell scripts
        "flake8", -- Linter cho Python
        "pyright", -- LSP cho Python
        "typescript-language-server", -- LSP cho TypeScript/JavaScript
        "tailwindcss-language-server", -- Tailwindcss
        "eslint_d", -- Linter cho JavaScript/TypeScript
        "prettierd", -- Formatter cho JS/TS/JSX/TSX
        "black", -- Formatter cho Python
      },
    },
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "jose-elias-alvarez/typescript.nvim",
    },
    opts = {
      servers = {
        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        -- TypeScript/JavaScript (React.js, Next.js, Node.js)
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      },
      setup = {
        ts_ls = function(_, opts)
          require("typescript").setup({
            server = opts,
          })
          return true
        end,
      },
    },
    init = function()
      -- Keymaps cho TypeScript
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
        if client.name == "tsserver" then
          vim.keymap.set(
            "n",
            "<leader>co",
            "<cmd>TypescriptOrganizeImports<CR>",
            { buffer = buffer, desc = "Organize Imports" }
          )
          vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { buffer = buffer, desc = "Rename File" })
        end
      end)
    end,
  },

  -- Formatter với Conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- JavaScript/TypeScript (React.js, Next.js, Node.js)
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        -- Python
        python = { "black" },
        -- Lua
        lua = { "stylua" },
        -- Shell
        sh = { "shfmt" },
      },
    },
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- JavaScript/TypeScript
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        -- Python
        python = { "flake8" },
        -- Shell
        sh = { "shellcheck" },
      },
    },
  },
}
