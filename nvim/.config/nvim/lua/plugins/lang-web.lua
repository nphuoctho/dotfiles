return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        vtsls = {

          ---@type lspconfig.settings.vtsls
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                  entriesLimit = 50,
                },
                maxInlayHintLength = 30,
              },
              enableMoveToFileCodeAction = true,
            },
            typescript = {
              -- Nested (not dotted root keys): Neovim resolves workspace/configuration
              -- sections with tbl_get(settings, "typescript", ...), so dotted keys are ignored.
              format = { enable = false },
              validate = { enable = true },
              suggestionActions = { enabled = false },
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
              format = { enable = false },
              validate = { enable = true },
              suggestionActions = { enabled = false },
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

  -- The oxc extra appends oxfmt to every JS/TS ft with no condition, so each save ran
  -- oxfmt then prettier. Use oxfmt only in projects with an oxfmt config; otherwise prettier.
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local has_fallback = {}
      for _, ft in ipairs({
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "vue",
        "svelte",
        "astro",
      }) do
        local list = vim.tbl_filter(function(f)
          return type(f) == "string" and f ~= "oxfmt"
        end, opts.formatters_by_ft[ft] or {})
        if #list > 0 then
          has_fallback[ft] = true
          opts.formatters_by_ft[ft] = vim.list_extend({ "oxfmt" }, list)
          opts.formatters_by_ft[ft].stop_after_first = true
        end
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.oxfmt = vim.tbl_deep_extend("force", opts.formatters.oxfmt or {}, {
        condition = function(_, ctx)
          if not has_fallback[vim.bo[ctx.buf].filetype] then
            return true
          end
          return vim.fs.root(ctx.dirname, { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }) ~= nil
        end,
      })
    end,
  },
}
