return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        vtsls = {
          -- vtsls-specific (nested, khác với settings.typescript)
          vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
                entriesLimit = 200,
              },
              maxInlayHintLength = 30,
            },
            enableMoveToFileCodeAction = true,
          },

          ---@type lspconfig.settings.vtsls
          settings = {
            -- Prettier (conform) handle formatting → tắt của vtsls
            ["typescript.format.enable"] = false,
            ["javascript.format.enable"] = false,

            -- Type checking: giữ (ESLint không làm được type-level)
            ["typescript.validate.enable"] = true,
            ["javascript.validate.enable"] = true,

            -- ESLint đã handle: no-unused-vars, prefer-const,... → tắt suggestion
            ["typescript.suggestionActions.enabled"] = false,
            ["javascript.suggestionActions.enabled"] = false,

            -- Suppress codes conflict với ESLint (thay cho handler publishDiagnostics
            -- đã deprecated trong Neovim 0.10+)
            -- 6133: declared but never read       (ESLint: no-unused-vars)
            -- 6196: declared but never used       (ESLint: no-unused-vars)
            -- 80001: require → import             (ESLint: no-require-imports)
            -- 80004: let → const                  (ESLint: prefer-const)
            ["typescript.tsserver.ignoredCodes"] = { 6133, 6196, 6198, 6192, 80001, 80004 },

            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative",
                importModuleSpecifierEnding = "auto",
                quoteStyle = "auto",
                preferTypeOnlyAutoImports = true,
                renameMatchingJsxTags = true,
                useAliasesForRenames = false,
                includePackageJsonAutoImports = "auto",
                organizeImports = {
                  caseSensitivity = "auto",
                  typeOrder = "first",
                  unicodeCollation = "ordinal",
                },
              },
              inlayHints = {
                parameterNames = {
                  enabled = "literals",
                  suppressWhenArgumentMatchesName = true,
                },
                parameterTypes = { enabled = false },
                variableTypes = {
                  enabled = false,
                  suppressWhenTypeMatchesName = true,
                },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              suggest = {
                enabled = true,
                autoImports = true,
                completeFunctionCalls = true,
                includeCompletionsForImportStatements = true,
                includeAutomaticOptionalChainCompletions = true,
                classMemberSnippets = { enabled = true },
                paths = true,
                completeJSDocs = true,
              },
              updateImportsOnFileMove = { enabled = "always" },
              reportStyleChecksAsWarnings = true,
              tsserver = {
                maxTsServerMemory = 4096,
                useSyntaxServer = "auto",
                log = "off",
              },
              -- Tránh nhảy vào .d.ts khi go-to-def
              preferGoToSourceDefinition = true,
              workspaceSymbols = {
                scope = "currentProject",
                excludeLibrarySymbols = true,
              },
            },

            javascript = {
              preferences = {
                importModuleSpecifier = "non-relative",
                importModuleSpecifierEnding = "auto",
                quoteStyle = "auto",
                renameMatchingJsxTags = true,
                useAliasesForRenames = false,
                organizeImports = {
                  caseSensitivity = "auto",
                  typeOrder = "first",
                  unicodeCollation = "ordinal",
                },
              },
              inlayHints = {
                parameterNames = {
                  enabled = "literals",
                  suppressWhenArgumentMatchesName = true,
                },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              suggest = {
                enabled = true,
                autoImports = true,
                completeFunctionCalls = true,
                paths = true,
              },
              updateImportsOnFileMove = { enabled = "always" },
              preferGoToSourceDefinition = true,
            },
          },

          on_attach = function(client, bufnr)
            -- Conform handle formatting → tắt LSP format capability
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            local function exec_cmd(cmd)
              vim.lsp.buf.execute_command({
                command = cmd,
                arguments = { vim.uri_from_bufnr(bufnr) },
              })
            end

            local map = function(key, fn, desc)
              vim.keymap.set("n", key, fn, { buffer = bufnr, desc = desc })
            end

            map("<leader>ci", function() exec_cmd("typescript.sortImports") end, "Sort Imports")
            map("<leader>cu", function() exec_cmd("typescript.removeUnusedImports") end, "Remove Unused Imports")
            map("<leader>co", function() exec_cmd("typescript.organizeImports") end, "Organize Imports")
            map("<leader>cA", function()
              vim.lsp.buf.code_action({
                apply = true,
                context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
              })
            end, "Add Missing Imports")
            map("<leader>cR", function() exec_cmd("typescript.restartTsServer") end, "Restart tsserver")
          end,
        },

        cssls = {},
        tailwindcss = {},
      },
      -- Toggle inlay hints: <leader>uh
      inlay_hints = { enabled = true },
    },
  },

  -- Mason: tools cần cài
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
