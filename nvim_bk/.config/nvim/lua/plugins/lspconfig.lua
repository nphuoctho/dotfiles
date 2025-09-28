return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Extend keymaps
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(keys, {
        {
          "gd",
          function()
            require("telescope.builtin").lsp_definitions({ reuse_win = false })
          end,
          desc = "Goto Definition (no window reuse)",
          has = "definition",
        },
      })

      opts.inlay_hints = { enabled = false }

      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        -- Lua
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ambiguity = "Opened",
                  await = "Opened",
                  codestyle = "None",
                  duplicate = "Opened",
                  global = "Opened",
                  luadoc = "Opened",
                  redefined = "Opened",
                  strict = "Opened",
                  strong = "Opened",
                  ["type-check"] = "Opened",
                  unbalanced = "Opened",
                  unused = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },

        -- JavaScript/TypeScript
        tsserver = {
          root_dir = require("lspconfig.util").root_pattern(".git"),
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },

        -- Tailwind CSS
        tailwindcss = {
          root_dir = require("lspconfig.util").root_pattern(".git"),
        },

        -- PHP
        intelephense = {},

        -- YAML
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },

        -- Python
        pyright = {
          root_dir = require("lspconfig.util").root_pattern(".git"),
          single_file_support = false,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
      })
    end,
  },
}
