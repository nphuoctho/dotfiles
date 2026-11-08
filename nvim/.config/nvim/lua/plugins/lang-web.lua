-- Web / TypeScript tooling.
-- Settings for vtsls MUST be nested tables: nvim answers workspace/configuration by
-- splitting the section on ".", so flat keys like ["typescript.format.enable"] are ignored.
-- LazyVim's vtsls extra copies `typescript` settings to `javascript` already.
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
              autoUseWorkspaceTsdk = true, -- use the project's node_modules/typescript (TS 6), not vtsls' bundled one
              enableMoveToFileCodeAction = true,
              experimental = {
                maxInlayHintLength = 30,
                -- LazyVim's extra turns server-side fuzzy ON; keep it OFF (and no entriesLimit):
                -- otherwise every response is `isIncomplete=true`, blink re-queries tsserver on each
                -- keystroke, and cancelled requests hit a vtsls "Reduce of empty array" bug.
                -- Off: blink caches the list per word and fuzzy-filters it in Rust.
                completion = { enableServerSideFuzzyMatch = false },
              },
            },
            typescript = {
              preferences = {
                -- "on": also offer packages that are not imported anywhere yet.
                -- "off"/"auto" hide them in projects with many dependencies (pnpm, Nest).
                includePackageJsonAutoImports = "on",
                -- NEVER true for NestJS: `import type { Service }` is erased at runtime,
                -- so constructor DI (emitDecoratorMetadata) breaks.
                preferTypeOnlyAutoImports = false,
                -- "non-relative" needs paths/imports; with nodenext it yields specifiers Node cannot resolve.
                importModuleSpecifier = "relative",
                importModuleSpecifierEnding = "auto", -- nodenext => always ".js"
                renameMatchingJsxTags = true,
                useAliasesForRenames = false,
              },
              suggest = {
                autoImports = true,
                completeFunctionCalls = true,
                includeCompletionsForImportStatements = true,
                includeAutomaticOptionalChainCompletions = true,
                classMemberSnippets = { enabled = true },
                paths = true,
                completeJSDocs = true,
              },
              suggestionActions = { enabled = false },
              updateImportsOnFileMove = { enabled = "always" },
              preferGoToSourceDefinition = true,
              workspaceSymbols = {
                scope = "currentProject",
                excludeLibrarySymbols = true,
              },
              inlayHints = {
                parameterNames = { enabled = "literals", suppressWhenArgumentMatchesName = true },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false, suppressWhenTypeMatchesName = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
        },

        -- TypeScript 7 native server (`tsc --lsp`), the default; set NVIM_TS_LSP=vtsls to get vtsls back.
        -- Measured on nest-taskflow: first full completion ~1s (vtsls 3-12s cold), no request queueing.
        -- Gaps: no refactor code actions, no executeCommand, uses its own TS 7 lib (not the project's TS 6).
        -- Settings live under "js/ts" and only `preferTypeOnlyAutoImports` was verified to take effect.
        tsc = {
          keys = {
            {
              "gD",
              function()
                local client = vim.lsp.get_clients({ bufnr = 0, name = "tsc" })[1]
                if not client then
                  return
                end
                local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
                client:request("custom/textDocument/sourceDefinition", params, function(err, result)
                  local locs = result and (vim.islist(result) and result or { result }) or {}
                  if err or #locs == 0 then
                    return vim.notify("No source definition found", vim.log.levels.INFO)
                  end
                  vim.lsp.util.show_document(locs[1], client.offset_encoding, { focus = true })
                end, 0)
              end,
              desc = "Goto Source Definition",
            },
          },
          settings = {
            ["js/ts"] = {
              inlayHints = {
                parameterNames = { enabled = "literals", suppressWhenArgumentMatchesName = true },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              preferences = {
                importModuleSpecifier = "relative",
                importModuleSpecifierEnding = "auto",
                preferTypeOnlyAutoImports = false, -- NEVER true for NestJS DI (see vtsls block)
                useAliasesForRenames = false,
              },
              suggest = {
                autoImports = true,
                includeCompletionsForImportStatements = true,
                includeAutomaticOptionalChainCompletions = true,
                classMemberSnippets = { enabled = true },
              },
              workspaceSymbols = { excludeLibrarySymbols = true },
            },
          },
        },

        cssls = {},

        -- Only start tailwindcss when the project really uses it. The lspconfig default
        -- falls back to ".git", so it attached to every git repo (e.g. backend-only Nest).
        tailwindcss = {
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local markers = require("lspconfig.util").insert_package_json({
              "tailwind.config.js",
              "tailwind.config.cjs",
              "tailwind.config.mjs",
              "tailwind.config.ts",
              "postcss.config.js",
              "postcss.config.cjs",
              "postcss.config.mjs",
              "postcss.config.ts",
            }, "tailwindcss", fname)
            local found = vim.fs.find(markers, { path = fname, upward = true })[1]
            if found then
              on_dir(vim.fs.dirname(found))
            end
          end,
        },

        -- oxlint LSP: type-aware mode makes nvim 0.12 (pull diagnostics) run tsgolint on every
        -- keystroke. Keep the LSP syntactic; type-aware lint runs via `pnpm lint` / CI.
        oxlint = {
          settings = {
            typeAware = false,
            fixKind = "safe_fix",
            run = "onSave",
          },
        },
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
      -- `tsc` (typescript@7) must be on PATH for lspconfig's tsc server; mason/bin is prepended in nvim.
      if vim.g.lazyvim_ts_lsp == "tsc" then
        table.insert(opts.ensure_installed, "tsc")
      end
    end,
  },

  -- Formatters: Prettier is the project formatter. The oxc extra appends oxfmt unconditionally,
  -- and oxfmt ignores .prettierrc (double quotes, width 100), so it fought Prettier and spammed errors.
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local fts = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "vue",
        "svelte",
        "astro",
      }
      for _, ft in ipairs(fts) do
        if opts.formatters_by_ft[ft] then
          opts.formatters_by_ft[ft].stop_after_first = true
        end
      end
      -- oxfmt only when the repo has an oxfmt config; otherwise fall through to prettier.
      opts.formatters = opts.formatters or {}
      opts.formatters.oxfmt = vim.tbl_deep_extend("force", opts.formatters.oxfmt or {}, {
        condition = function(_, ctx)
          return vim.fs.root(ctx.filename, { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts", "oxfmt.config.mts" })
            ~= nil
        end,
      })
    end,
  },
}
