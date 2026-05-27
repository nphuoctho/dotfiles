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
              typeCheckingMode = "basic",
              -- Ruff handles imports → tell basedpyright to stay out
              disableOrganizeImports = true,
              analysis = {
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
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
                inlayHints = {
                  variableTypes = true,
                  callArgumentNames = true,
                  functionReturnTypes = true,
                  genericTypes = false,
                },
              },
            },
            python = {
              analysis = {
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
      },
    },
  },

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
