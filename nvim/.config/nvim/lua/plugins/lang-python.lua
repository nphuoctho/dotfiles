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
