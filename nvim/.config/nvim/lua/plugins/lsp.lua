---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Mason
      {
        "mason-org/mason.nvim",
        cmd = "Mason",
        opts = {
          ensure_installed = {
            -- Formatters
            "prettier",
            "biome",
            "oxfmt",
            "stylua",
            "clang-format",

            -- Linters
            "oxlint",
            "eslint_d",
          },
        },
      },

      -- Mason LSP
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            -- Web / JS / TS
            "ts_ls",
            "html",
            "cssls",
            "tailwindcss",
            "jsonls",

            -- Lua
            "lua_ls",

            -- Python
            "basedpyright",
            "ruff",

            -- C / C++
            "clangd",
          },
        },
      },
    },

    config = function()
      -- Mason
      require("mason").setup()
      require("mason-lspconfig").setup()

      -- Capabilities
      local base_capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require("blink.cmp").get_lsp_capabilities(base_capabilities)

      -- LSP Attach Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(event)
          require("config.keymaps.lsp").on_attach(event.buf)
        end,
      })

      -- Diagnostics
      vim.diagnostic.config {
        virtual_text = { prefix = "●" },
        signs = true,
        update_in_insert = false,
        float = { border = "rounded" },
      }

      -- Helper setup
      ---@param name string
      ---@param config vim.lsp.Config?
      local function setup_lsp(name, config)
        config = config or {}

        config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end

      -- LSP Configs
      -- Lua
      setup_lsp("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Web / JS / TS
      setup_lsp("ts_ls", {})
      setup_lsp("html", {})
      setup_lsp("cssls", {})
      setup_lsp("jsonls", {})
      setup_lsp("tailwindcss", {})

      -- Python
      setup_lsp("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard", -- hoặc "strict"
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- ✅ ruff LSP
      setup_lsp("ruff", {
        on_attach = function(client, _)
          client.server_capabilities.hoverProvider = false
        end,
      })

      -- C / C++
      setup_lsp("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
        },
      })
    end,
  },
}
