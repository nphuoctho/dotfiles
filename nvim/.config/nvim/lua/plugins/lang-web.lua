return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        vtsls = {
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
            ["typescript.format.enable"] = false,
            ["javascript.format.enable"] = false,
            ["typescript.validate.enable"] = true,
            ["javascript.validate.enable"] = true,
            ["typescript.suggestionActions.enabled"] = false,
            ["javascript.suggestionActions.enabled"] = false,

            -- Suppress codes already handled by ESLint
            -- 6133/6196/6198/6192: unused / declared-but-never-used
            -- 80001: require → import
            -- 80004: let → const
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
                maxTsServerMemory = 3072,
                useSyntaxServer = "auto",
                log = "off",
              },
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
        },

        cssls = {},
        tailwindcss = {},
      },
      inlay_hints = { enabled = true },
    },
  },

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
