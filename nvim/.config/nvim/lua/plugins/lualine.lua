return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    -- Utility: Check if buffer is not empty
    local function buffer_not_empty()
      return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end

    -- Utility: Check if width is wide enough
    local function hide_in_width()
      return vim.fn.winwidth(0) > 80
    end

    -- Get current active LSP client
    local function lsp_client()
      local msg = "No Active LSP"
      local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })
      if next(clients) == nil then
        return msg
      end
      for _, client in ipairs(clients) do
        local ft = client.config.filetypes or {}
        if vim.tbl_contains(ft, buf_ft) then
          return client.name
        end
      end
      return msg
    end

    lualine.setup({
      options = {
        theme = "auto", -- Use default theme (based on your colorscheme)
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = {
          { "mode", icon = "" },
        },
        lualine_b = {
          { "branch" },
          {
            "diff",
            symbols = { added = " ", modified = "󰝤 ", removed = " " },
            cond = hide_in_width,
          },
        },
        lualine_c = {
          {
            "filename",
            cond = buffer_not_empty,
            path = 1, -- show relative path
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
          },
          {
            lsp_client,
            icon = "",
            cond = hide_in_width,
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree", "fugitive", "quickfix", "toggleterm" },
    })
  end,
}
