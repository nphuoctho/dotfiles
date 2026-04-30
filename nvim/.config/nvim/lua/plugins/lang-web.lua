return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        vtsls = {
          ---@type lspconfig.settings.vtsls
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "relative",
              },
            },
            javascript = {
              inlayHints = {
                parameterNames = { enabled = "all" },
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx)
              if result and result.diagnostics then
                -- Các codes này đã có ESLint handle, suppress TS để tránh double
                local ignored = {
                  -- Unused
                  [6133] = true, -- declared but never read
                  [6196] = true, -- declared but never used (type)
                  [6198] = true, -- rest param unused
                  [6192] = true, -- all imports unused
                  -- Module
                  [80001] = true, -- require() → import (ESLint: no-require-imports)
                  -- Style suggestions (ESLint: prefer-const,...)
                  [80004] = true, -- let → const
                  -- Bỏ comment dòng nào nếu KHÔNG dùng ESLint rule tương đương
                }
                result.diagnostics = vim.tbl_filter(function(d)
                  return not ignored[d.code]
                end, result.diagnostics)
              end
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
            end,
          },
        },

        -- CSS LSP
        cssls = {},

        -- Tailwind
        tailwindcss = {},
      },
      -- Inlay hints: toggle bằng <leader>uh
      inlay_hints = { enabled = true },
    },
  },

  -- Mason: đảm bảo các tools được cài
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "prettier",
        "eslint-lsp",
        "css-lsp",
        "tailwindcss-language-server",
      })
    end,
  },
}
