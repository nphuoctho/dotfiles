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
                -- fieldalignment: noisy, deprecated (chuyển vào govet modernizer)
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
              semanticTokens = true,
            },
          },
        },
        -- Templ LSP (Go templating cho htmx/web)
        templ = {},
      },
      setup = {
        gopls = function(_, _)
          -- Override LazyVim's gopls setup: nil-safe access to semantic tokens.
          -- Newer Neovim/nvim-lspconfig versions không còn đặt full default
          -- capabilities ở client.config.capabilities, nên textDocument có thể nil.
          Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
            if client.server_capabilities.semanticTokensProvider then
              return
            end
            local caps = client.config.capabilities or {}
            local semantic = (caps.textDocument or {}).semanticTokens
              or vim.lsp.protocol.make_client_capabilities().textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end)
        end,
      },
    },
  },

  -- Mason: chỉ thêm tool không có sẵn trong LazyVim go extra
  -- (goimports, gofumpt, golangci-lint, delve, gomodifytags, impl đã có sẵn)
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "goimports-reviser", -- sort imports theo group (std / 3rd / local)
        "templ", -- templ LSP
      })
    end,
  },

  -- Treesitter: thêm templ
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "templ" })
    end,
  },

  -- Conform: wire goimports-reviser thay cho goimports mặc định
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

  -- Filetype association cho .templ
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
