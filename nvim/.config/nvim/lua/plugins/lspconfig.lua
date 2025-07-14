return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local mason_registry = require("mason-registry")

    local on_attach = function(client, bufnr)
      -- Disable LSP formatting to avoid conflicts with conform.nvim
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      -- Keymaps for LSP
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end

    require("mason-lspconfig").setup({
      handlers = {
        function(server)
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
          })
        end,
        ["ts_ls"] = function()
          local vue_ts_plugin_path = mason_registry.get_package("vue-language-server"):get_install_path()
            .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
          lspconfig.ts_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_ts_plugin_path,
                  languages = { "javascript", "typescript", "vue" },
                },
              },
            },
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          })
        end,
        ["vue_ls"] = function()
          lspconfig.vue_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
              vue = {
                hybridMode = false, -- Use ts_ls for TypeScript in script sections
              },
            },
            filetypes = { "vue" },
          })
        end,
        ["pyright"] = function()
          lspconfig.pyright.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  diagnosticMode = "workspace",
                },
              },
            },
          })
        end,
      },
    })
  end,
}
