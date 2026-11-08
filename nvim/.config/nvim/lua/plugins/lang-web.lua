-- Web / TypeScript tooling.
-- Settings for vtsls MUST be nested tables: nvim answers workspace/configuration by
-- splitting the section on ".", so flat keys like ["typescript.format.enable"] are ignored.
-- LazyVim's vtsls extra copies `typescript` settings to `javascript` already.
-- tsc has no `source.addMissingImports`; the "Add all missing imports" quickfix needs the buffer's
-- LSP diagnostics passed explicitly (`source.fixAll` would also generate method stubs).
local function add_missing_imports()
  local diagnostics = {}
  for _, d in ipairs(vim.diagnostic.get(0)) do
    if d.user_data and d.user_data.lsp then
      table.insert(diagnostics, d.user_data.lsp)
    end
  end
  vim.lsp.buf.code_action({
    apply = true,
    filter = function(action)
      return action.title == "Add all missing imports"
    end,
    context = { only = { "quickfix" }, diagnostics = diagnostics },
  })
end

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
              -- Nested (not dotted root keys): Neovim resolves workspace/configuration
              -- sections with tbl_get(settings, "typescript", ...), so dotted keys are ignored.
              format = { enable = false },
              validate = { enable = true },
              suggestionActions = { enabled = false },
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
                organizeImports = {
                  caseSensitivity = "auto",
                  typeOrder = "first",
                  unicodeCollation = "ordinal",
                },
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
            -- Keys must live here (not in an autocmd): LazyVim re-applies its generic <leader>cA
            -- "Source Action" on every client attach, which clobbers buffer-local autocmd maps.
            { "<leader>cA", add_missing_imports, desc = "Add Missing Imports", has = "codeAction" },
            { "<leader>cM", add_missing_imports, desc = "Add Missing Imports", has = "codeAction" },
            {
              "<leader>cD",
              function()
                vim.lsp.buf.code_action({ apply = true, context = { only = { "source.fixAll" }, diagnostics = {} } })
              end,
              desc = "Fix All (may generate stubs)",
              has = "codeAction",
            },
            { "<leader>cT", "<cmd>lsp restart tsc<cr>", desc = "Restart tsc" },
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
                organizeImports = { caseSensitivity = "auto", typeOrder = "first", unicodeCollation = "ordinal" },
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
            local config_files = {
              "tailwind.config.js",
              "tailwind.config.cjs",
              "tailwind.config.mjs",
              "tailwind.config.ts",
              "postcss.config.js",
              "postcss.config.cjs",
              "postcss.config.mjs",
              "postcss.config.ts",
            }
            -- Walk every ancestor: Tailwind v4 has no config file and in a pnpm monorepo
            -- `tailwindcss` may be declared only in the root package.json.
            for dir in vim.fs.parents(fname) do
              for _, name in ipairs(config_files) do
                if vim.uv.fs_stat(vim.fs.joinpath(dir, name)) then
                  return on_dir(dir)
                end
              end
              local pkg = vim.fs.joinpath(dir, "package.json")
              if vim.uv.fs_stat(pkg) then
                for line in io.lines(pkg) do
                  if line:find("tailwindcss", 1, true) then
                    return on_dir(dir)
                  end
                end
              end
            end
          end,
        },

        -- oxlint LSP: type-aware mode makes nvim 0.12 (pull diagnostics) run tsgolint on every
        -- keystroke. Keep the LSP syntactic; type-aware lint runs via `pnpm lint` / CI.
        oxlint = {
          settings = {
            typeAware = false,
            fixKind = "safe_fix",
          },
        },
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

  -- lspconfig's `tsc` server needs a TypeScript >= 7 `tsc` on PATH (mason/bin is prepended inside nvim).
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if vim.g.lazyvim_ts_lsp == "tsc" then
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "tsc")
      end
    end,
  },
}
