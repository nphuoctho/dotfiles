return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    format_on_save = function(bufnr)
      local disable_filetypes = { "sql", "markdown" }
      if vim.tbl_contains(disable_filetypes, vim.bo[bufnr].filetype) then
        return nil
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    formatters_by_ft = {
      lua = { "stylua" },

      -- Fullstack Web Developer
      javascript = { "biome", "prettier", "oxfmt", stop_after_first = true },
      typescript = { "biome", "prettier", "oxfmt", stop_after_first = true },
      typescriptreact = { "biome", "prettier", "oxfmt", stop_after_first = true },
      javascriptreact = { "biome", "prettier", "oxfmt", stop_after_first = true },

      yaml = { "prettier" },
      markdown = { "prettier" },
      html = { "biome", "prettier" },
      css = { "biome", "prettier" },
      scss = { "biome", "prettier" },
      json = { "biome", "prettier", stop_after_first = true },
      jsonc = { "biome", "prettier", stop_after_first = true },

      -- Python
      python = { "ruff_fix", "ruff_format" },

      -- C / CPP
      c = { "clang_format" },
      cpp = { "clang_format" },
    },

    formatters = {
      biome = {
        require_cwd = true, -- chỉ chạy khi có biome.json
      },
      prettier = {
        require_cwd = false, -- fallback khi không có biome
      },
      oxfmt = {
        require_cwd = true, -- chỉ chạy khi có oxfmt config
      },
      ruff_format = {
        args = { "format", "--stdin-filename", "$FILENAME", "-" },
      },
      ruff_fix = {
        command = "ruff",
        args = {
          "check",
          "--select=F401,I",
          "--fix",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
        stdin = true,
      },
      clang_format = {
        args = { "--style=file", "--fallback-style=Google" }, -- ưu tiên .clang-format, fallback Google style
      },
    },

    format_after_save = function(bufnr)
      local ts_fts = {
        typescript = true,
        typescriptreact = true,
        javascript = true,
        javascriptreact = true,
      }
      if not ts_fts[vim.bo[bufnr].filetype] then
        return
      end

      vim.lsp.buf.code_action {
        apply = true,
        context = { only = { "source.removeUnused.ts" }, diagnostics = {} },
        filter = function(action)
          return action.kind == "source.removeUnused.ts"
        end,
      }

      vim.defer_fn(function()
        vim.lsp.buf.code_action {
          apply = true,
          context = { only = { "source.organizeImports" }, diagnostics = {} },
          filter = function(action)
            return action.kind == "source.organizeImports"
          end,
        }
      end, 200)
    end,
  },
}
