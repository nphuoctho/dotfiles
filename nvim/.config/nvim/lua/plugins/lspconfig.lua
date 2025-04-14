return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "pyright",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      {
        "smjonas/inc-rename.nvim",
        config = true,
      },
    },
    opts = function(_, opts)
      -- Add or extend the default servers
      opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
        pyright = {
          settings = {
            python = {
              venvPath = ".", -- Look in current folder for virtual envs
              venv = ".venv", -- Your venv folder name
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                extraPaths = { "./src" }, -- if needed
              },
            },
          },
        },
        tsserver = {},
      })

      -- Override setup for specific servers
      opts.setup = opts.setup or {}

      opts.setup.tsserver = function(_, server_opts)
        require("typescript").setup({ server = server_opts })
        return true
      end

      -- Custom keymaps (only on attach)
      local on_attach = require("lazyvim.util").lsp.on_attach
      on_attach(function(_, buffer)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
        end

        map("n", "<leader>co", "TypescriptOrganizeImports", "Organize Imports")
        map("n", "<leader>cR", "TypescriptRenameFile", "Rename File")
      end)

      -- Add custom rename key (using inc-rename)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "<leader>cr",
        function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename (inc-rename.nvim)",
        has = "rename",
      }
    end,
  },
}
