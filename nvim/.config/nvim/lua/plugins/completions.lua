return {
  {
    "saghen/blink.cmp",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      keymap = {

        preset = "super-tab",
        -- extend / override the preset
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
        trigger = {
          show_in_snippet = false, -- no popup while inside a snippet placeholder
        },

        list = {
          selection = {
            preselect = true, -- highlight the first item
            auto_insert = false, -- wait for <CR> to insert
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
