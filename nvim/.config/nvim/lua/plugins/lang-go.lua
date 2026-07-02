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
                gc_details = false,
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
                useany = true,
                shadow = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              -- off to dodge LazyVim's broken workaround
              semanticTokens = false,
            },
          },
        },
        templ = {}, -- templ LSP for htmx/web
      },
      setup = {
        -- override LazyVim's workaround
        gopls = function(_, _)
          return false
        end,
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
        go = { "goimports-reviser", "gofumpt" },
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
