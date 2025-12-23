return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      javascript = { 'prettierd', 'eslint_d' },
      javascriptreact = { 'prettierd', 'eslint_d' },
      typescript = { 'prettierd', 'eslint_d' },
      typescriptreact = { 'prettierd', 'eslint_d' },
      html = { 'prettierd' },
      json = { 'prettierd' },
      yaml = { 'prettierd' },
      markdown = { 'prettierd' },

      lua = { 'stylua' },
    },
    -- Formatter
    -- formatters = {
    --   ruff_format = {
    --     command = 'ruff',
    --     args = { 'format', '-' },
    --     stdin = true,
    --   },
    --
    --   ruff_fix = {
    --     command = 'ruff',
    --     args = {
    --       'check',
    --       '--fix',
    --       -- '--extend-select',
    --       -- 'I', -- <— isort rules
    --       '--stdin-filename',
    --       '$FILENAME',
    --       '-',
    --     },
    --     stdin = true,
    --   },
    -- },
  },
}
