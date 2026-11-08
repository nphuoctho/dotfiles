return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                -- fieldalignment: noisy, deprecated
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                unusedvariable = true,
                shadow = true,
              },
              usePlaceholders = true,
              staticcheck = true,
              directoryFilters = { "-**/node_modules" }, -- default; a bare "-node_modules" only matched the module root
            },
          },
        },
        templ = {}, -- templ LSP for htmx/web
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "goimports-reviser", -- sort imports by group (std / 3rd / local)
        "templ", -- templ LSP
      })
    end,
  },

  -- Treesitter: add templ
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "templ" })
    end,
  },

  -- Conform: use goimports-reviser instead of the default goimports
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- goimports adds/removes imports; reviser alone only regroups them (it does not add `sort`/drop `os`)
        go = { "goimports", "goimports-reviser", "gofumpt" },
        templ = { "templ" },
      },
    },
  },

  -- filetype mapping for .templ
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.filetype.add({
        extension = { templ = "templ" },
      })
    end,
  },

  -- LazyVim lints on BufReadPost/InsertLeave/BufWritePost (all filetypes). golangci-lint spawns a
  -- whole-package run (~1-3 s of CPU) each time, so lint on save only (also applies to hadolint,
  -- markdownlint-cli2, fish).
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.events = { "BufWritePost" }
    end,
  },

  -- DAP Go
  {
    "leoluz/nvim-dap-go",
    keys = {
      { "<leader>dg", "", desc = "+Go DAP", ft = "go" },
      {
        "<leader>dgt",
        function()
          require("dap-go").debug_test()
        end,
        desc = "Debug Go Test (Nearest)",
        ft = "go",
      },
      {
        "<leader>dgl",
        function()
          require("dap-go").debug_last_test()
        end,
        desc = "Debug Last Go Test",
        ft = "go",
      },
    },
  },
}
