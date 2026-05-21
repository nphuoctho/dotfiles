return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        basedpyright = {
          ---@type lspconfig.settings.basedpyright
          settings = {
            basedpyright = {
              typeCheckingMode = "standard", -- "off" | "basic" | "standard" | "strict"
              analysis = {
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,

                -- ─── Performance tuning ────────────────────────────────
                -- Chỉ analyze file đang mở, không scan toàn workspace
                -- Trade-off: mất "find references" cross-file, nhưng nhanh hơn nhiều
                diagnosticMode = "openFilesOnly", -- vs "workspace"

                -- Index depth: số file basedpyright index để autocomplete
                -- Default 2000, hạ xuống nếu project quá lớn
                -- userFileIndexingLimit = 2000,

                -- Loại trừ các thư mục không cần analyze
                exclude = {
                  "**/node_modules",
                  "**/__pycache__",
                  "**/.venv",
                  "**/venv",
                  "**/build",
                  "**/dist",
                  "**/.mypy_cache",
                  "**/.pytest_cache",
                  "**/.ruff_cache",
                },

                -- Inlay hints: tắt nếu muốn giảm tải thêm
                inlayHints = {
                  variableTypes = true,
                  callArgumentNames = true,
                  functionReturnTypes = true,
                  genericTypes = false,
                },
              },

              -- Disable telemetry (basedpyright không có, nhưng để defensive)
              disableOrganizeImports = false, -- ruff handle
            },

            -- Python interpreter: để venv-selector handle
            python = {
              analysis = {
                -- Mirror settings phía trên (basedpyright dùng cả 2 namespace)
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
      },
    },
  },

  -- Venv selector: tự detect virtualenv (uv, poetry, venv,...)
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
  },
}
