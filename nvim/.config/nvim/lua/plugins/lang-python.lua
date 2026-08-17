return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          -- Prefer the project's .venv interpreter so imports/completion resolve
          -- against installed deps; fall back to system python when absent.
          before_init = function(_, config)
            local root = config.root_dir or vim.fn.getcwd()
            local py = root .. "/.venv/bin/python"
            if vim.uv.fs_stat(py) then
              config.settings = config.settings or {}
              config.settings.python = config.settings.python or {}
              config.settings.python.pythonPath = py
            end
          end,
          settings = {
            basedpyright = {
              typeCheckingMode = "basic",
              analysis = {
                inlayHints = {
                  variableTypes = true,
                  callArgumentNames = true,
                  functionReturnTypes = true,
                  genericTypes = false,
                },
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
          notify_user_on_activate = true,
        },
      },
    },
    ft = "python",
  },
}
