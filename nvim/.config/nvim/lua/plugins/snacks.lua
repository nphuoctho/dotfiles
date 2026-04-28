---@type LazySpec
return {
  -- Notifications + utilities (chỉ bật những module cần)
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    notifier = { enabled = true, timeout = 3000 },
    quickfile = { enabled = true }, -- mở file nhanh hơn trước khi treesitter load
    bigfile = { enabled = true }, -- disable heavy features cho file > 1.5MB
    scroll = { enabled = true }, -- smooth scrolling
    statuscolumn = { enabled = true },
    lazygit = { enabled = true },
    picker = { enabled = true },
    words = { enabled = true },
    terminal = { enabled = true },
    dashboard = { enabled = true },
    gh = { enabled = true },
    input = { enabled = true },
    scope = { enabled = true },
    indent = {
      enabled = true,
      only_scope = true,
      only_current = true,

      scope = {
        enabled = true,
      },

      chunk = {
        enabled = true,
        char = {
          horizontal = "─",
          vertical = "│",
          corner_top = "╭",
          corner_bottom = "╰",
          arrow = "─",
        },
      },
    },

    styles = {
      lazygit = {
        border = "rounded",
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        require("config.keymaps.snacks").setup()

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
