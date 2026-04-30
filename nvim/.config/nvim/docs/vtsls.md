```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {

          -- ─── vtsls-specific settings ────────────────────────────────────────
          -- Dùng workspace TypeScript thay vì bundled (quan trọng cho NestJS/monorepo)
          vtsls = {
            autoUseWorkspaceTsdk = true,

            -- Server-side fuzzy match: filter completion trước khi trả về client
            -- Giảm số lượng items rác từ tsserver, blink.cmp nhanh hơn
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
                entriesLimit = 200, -- cap tránh blink bị overwhelm
              },
              maxInlayHintLength = 30, -- tránh inlay hint quá dài che code
            },

            enableMoveToFileCodeAction = true,
          },

          settings = {
            -- ─── Tắt formatter của vtsls ──────────────────────────────────────
            -- Prettier (conform.nvim) sẽ handle formatting
            -- Nếu để true: conflict khi format → double format hoặc revert nhau
            ["typescript.format.enable"] = false,
            ["javascript.format.enable"] = false,

            -- ─── Validation: GIỮ nguyên TS type checking ─────────────────────
            -- ESLint không làm được type-level checks, chỉ vtsls mới làm được
            -- Các rule như no-unused-vars sẽ được suppress bằng ignoredCodes bên dưới
            ["typescript.validate.enable"] = true,
            ["javascript.validate.enable"] = true,

            -- ─── Tắt suggestion actions của vtsls ────────────────────────────
            -- ESLint đã handle: no-unused-vars, prefer-const, eqeqeq,...
            -- Để true: double warnings, confusing UX
            ["typescript.suggestionActions.enabled"] = false,
            ["javascript.suggestionActions.enabled"] = false,

            -- ─── Suppress diagnostic codes conflict với ESLint ────────────────
            -- 6133: 'X' is declared but its value is never read (ESLint: no-unused-vars)
            -- 6196: 'X' is declared but never used (ESLint: no-unused-vars)
            -- 80001: 'require' calls may be converted to imports (ESLint handles modules)
            -- 7044: Parameter 'X' implicitly has an 'any[]' type (thường dùng _prefix)
            ["typescript.tsserver.ignoredCodes"] = { 6133, 6196, 80001 },

            -- ─── TypeScript preferences ───────────────────────────────────────
            typescript = {
              preferences = {
                -- Import style: project-relative phù hợp với NestJS/monorepo
                -- "shortest" | "relative" | "non-relative" | "project-relative"
                importModuleSpecifier = "non-relative",

                -- Ending: "auto" để tsserver tự quyết theo tsconfig moduleResolution
                importModuleSpecifierEnding = "auto",

                -- Quote style: "auto" để detect từ file hiện tại
                -- Prettier sẽ normalize anyway nên để auto
                quoteStyle = "auto",

                -- type keyword trong auto-imports (TypeScript 5.3+)
                -- Tốt cho tree-shaking và rõ ràng hơn
                preferTypeOnlyAutoImports = true,

                -- Rename JSX tag matching (TypeScript 5.1+)
                renameMatchingJsxTags = true,

                -- Không dùng aliases khi rename, tránh surprise
                useAliasesForRenames = false,

                -- Package.json auto imports: auto để tsserver tự quyết theo perf
                includePackageJsonAutoImports = "auto",

                -- Organize imports: sort behavior
                organizeImports = {
                  caseSensitivity = "auto",
                  typeOrder       = "first", -- type imports lên đầu (clean hơn)
                  unicodeCollation = "ordinal",
                },
              },

              -- ─── Inlay hints ──────────────────────────────────────────────
              -- Chỉ bật những gì thực sự có ích, tránh visual noise
              inlayHints = {
                -- Tên param khi gọi hàm: chỉ literals (số, string) → ít noise nhất
                -- "none" | "literals" | "all"
                parameterNames = {
                  enabled                        = "literals",
                  suppressWhenArgumentMatchesName = true,
                },
                -- Type của param: tắt, quá noisy
                parameterTypes    = { enabled = false },
                -- Type của variable khi implicit: tắt (có hover để xem)
                variableTypes     = {
                  enabled                     = false,
                  suppressWhenTypeMatchesName = true,
                },
                -- Type của class property: bật, hữu ích khi đọc NestJS entities
                propertyDeclarationTypes = { enabled = true },
                -- Return type của function: bật, tránh phải hover mỗi khi xem
                functionLikeReturnTypes  = { enabled = true },
                -- Giá trị của enum members: bật, tiết kiệm 1 lần lookup
                enumMemberValues         = { enabled = true },
              },

              -- ─── Suggest ──────────────────────────────────────────────────
              suggest = {
                enabled                              = true,
                autoImports                          = true,
                completeFunctionCalls                = true, -- tự điền params placeholder
                includeCompletionsForImportStatements = true,
                includeAutomaticOptionalChainCompletions = true,
                classMemberSnippets                  = { enabled = true },
                paths                                = true,
                completeJSDocs                       = true,
              },

              -- Update import paths khi rename file
              updateImportsOnFileMove = { enabled = "always" },

              -- Report style checks (missing semicolons,...) là warning, không error
              reportStyleChecksAsWarnings = true,

              -- tsserver performance
              tsserver = {
                -- 4GB cho project lớn (NestJS + monorepo có thể cần)
                maxTsServerMemory = 4096,
                -- syntax server: auto là tốt nhất
                useSyntaxServer = "auto",
                -- Log: off trong production config, bật khi debug
                log = "off",
              },

              -- Go to definition: ưu tiên source file, không nhảy vào .d.ts
              preferGoToSourceDefinition = true,

              -- Workspace symbols: chỉ search project hiện tại cho nhanh
              workspaceSymbols = {
                scope                  = "currentProject",
                excludeLibrarySymbols = true,
              },
            },

            -- ─── JavaScript (mirror với TypeScript) ──────────────────────────
            javascript = {
              preferences = {
                importModuleSpecifier        = "non-relative",
                importModuleSpecifierEnding  = "auto",
                quoteStyle                   = "auto",
                renameMatchingJsxTags        = true,
                useAliasesForRenames         = false,
                organizeImports = {
                  caseSensitivity = "auto",
                  typeOrder       = "first",
                  unicodeCollation = "ordinal",
                },
              },
              inlayHints = {
                parameterNames = {
                  enabled                        = "literals",
                  suppressWhenArgumentMatchesName = true,
                },
                parameterTypes           = { enabled = false },
                variableTypes            = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes  = { enabled = true },
              },
              suggest = {
                enabled          = true,
                autoImports      = true,
                completeFunctionCalls = true,
                paths            = true,
              },
              updateImportsOnFileMove = { enabled = "always" },
              preferGoToSourceDefinition = true,
            },
          },

          -- ─── on_attach: keymaps + auto import actions on save ──────────────
          on_attach = function(client, bufnr)
            -- Tắt formatting capability của vtsls
            -- Conform sẽ handle thay vì LSP format
            client.server_capabilities.documentFormattingProvider      = false
            client.server_capabilities.documentRangeFormattingProvider = false

            local function exec_cmd(cmd)
              vim.lsp.buf.execute_command({
                command   = cmd,
                arguments = { vim.uri_from_bufnr(bufnr) },
              })
            end

            local map = function(key, fn, desc)
              vim.keymap.set("n", key, fn, { buffer = bufnr, desc = desc })
            end

            map("<leader>ci", function() exec_cmd("typescript.sortImports") end,          "Sort Imports")
            map("<leader>cu", function() exec_cmd("typescript.removeUnusedImports") end,  "Remove Unused Imports")
            map("<leader>co", function() exec_cmd("typescript.organizeImports") end,      "Organize Imports")
            map("<leader>cA", function()
              vim.lsp.buf.code_action({
                apply   = true,
                context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
              })
            end, "Add Missing Imports")
            map("<leader>cR", function() exec_cmd("typescript.restartTsServer") end, "Restart tsserver")

            -- Auto import cleanup on save
            local group = vim.api.nvim_create_augroup("VtslsOnSave_" .. bufnr, { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group    = group,
              buffer   = bufnr,
              callback = function()
                exec_cmd("typescript.removeUnusedImports")
                exec_cmd("typescript.sortImports")
              end,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group    = group,
              buffer   = bufnr,
              callback = function()
                pcall(vim.api.nvim_del_augroup_by_name, "VtslsOnSave_" .. bufnr)
              end,
            })
          end,
        },
      },

      -- Toggle inlay hints globally: <leader>uh (LazyVim default)
      inlay_hints = { enabled = true },
    },
  },
}
```
