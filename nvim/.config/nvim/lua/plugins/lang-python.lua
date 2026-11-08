return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyrefly = {
          -- The LSP default preset is "basic", which drops bad-assignment / missing-attribute /
          -- missing-argument errors; "default" matches basedpyright's "basic" in head-to-head tests.
          init_options = { pyrefly = { typeCheckingMode = "default" } },
        },
        basedpyright = {
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
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if vim.g.lazyvim_python_lsp == "pyrefly" then
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "pyrefly")
      end
    end,
  },
}
