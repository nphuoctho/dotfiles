return {
  {
    "saghen/blink.cmp",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      keymap = {

        preset = "super-tab",
        -- Override / thêm trên preset
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

        -- Scroll doc window
        ["<C-d>"] = { "scroll_documentation_down" },
        ["<C-u>"] = { "scroll_documentation_up" },

        -- Snippet jump
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

        -- Navigate items
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },

        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
      },

      -- ─── Completion behavior ──────────────────────────────────────────────
      completion = {
        -- Tự động show khi gõ, không cần trigger thủ công
        trigger = {
          show_in_snippet = false, -- tắt popup khi đang trong snippet placeholder
        },

        list = {
          selection = {
            -- Không preselect khi đang jump snippet
            preselect = true, -- Tự insert item khi chỉ có 1 kết quả duy nhất
            auto_insert = false,
          },
        },

        -- ─── Menu ───────────────────────────────────────────────────────────
        menu = {
          border = "rounded", -- "none" | "single" | "double" | "rounded"
        },

        -- ─── Documentation popup ────────────────────────────────────────────
        documentation = {
          auto_show = false,
          window = {
            border = "rounded",
          },
        },
      },
    },
  },
}
