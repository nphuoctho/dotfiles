---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format { async = true }
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

    -- TS/JS: organize imports sau khi save (tách khỏi format_after_save)
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("TsOrganizeImports", { clear = true }),
      pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
      callback = function()
        vim.defer_fn(function()
          vim.lsp.buf.code_action {
            apply = true,
            context = { only = { "source.organizeImports" }, diagnostics = {} },
            filter = function(a)
              return a.kind == "source.organizeImports"
            end,
          }
        end, 200)
      end,
    })
  end,
  opts = {
    format_on_save = function(bufnr)
      -- Biome LSP đang active → để LSP handle, conform không chạy
      for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
        if client.name == "biome" then
          return nil
        end
      end

      local skip_fts = { sql = true, markdown = true }
      if skip_fts[vim.bo[bufnr].filetype] then
        return nil
      end

      return { timeout_ms = 500, lsp_fallback = false }
    end,

    formatters_by_ft = {
      lua = { "stylua" },

      javascript = { "biome", "oxfmt", "prettier", stop_after_first = true },
      typescript = { "biome", "oxfmt", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "oxfmt", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "oxfmt", "prettier", stop_after_first = true },
      json = { "biome", "prettier", stop_after_first = true },
      jsonc = { "biome", "prettier", stop_after_first = true },

      -- Biome không support html/css/scss
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },

      python = { "ruff_fix", "ruff_format" },
      c = { "clang_format" },
      cpp = { "clang_format" },

      ["*"] = { "trim_whitespace" },
    },

    formatters = {
      biome = {
        condition = function(_, ctx)
          return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.filename, upward = true })[1] ~= nil
        end,
      },
      oxfmt = {
        condition = function(_, ctx)
          return vim.fs.find({ "oxlint.json", ".oxlintrc" }, { path = ctx.filename, upward = true })[1] ~= nil
        end,
      },
      prettier = {},
      ruff_format = {
        args = { "format", "--stdin-filename", "$FILENAME", "-" },
      },
      ruff_fix = {
        command = "ruff",
        args = { "check", "--select=F401,I", "--fix", "--stdin-filename", "$FILENAME", "-" },
        stdin = true,
      },
      clang_format = {
        args = { "--style=file", "--fallback-style=Google" },
      },
    },
  },
}
