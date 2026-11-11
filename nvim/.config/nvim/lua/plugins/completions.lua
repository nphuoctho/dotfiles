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
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" }, -- popup open: next item; popup closed: jump snippet placeholder
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

        -- Navigate items
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },

        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
      },

      -- ─── Completion behavior ──────────────────────────────────────────────
      completion = {
        trigger = {
          show_in_snippet = true, -- keep the popup inside snippet placeholders (e.g. vtsls completeFunctionCalls args)
        },

        list = {
          selection = {
            preselect = true, -- auto-select first item; <CR> accepts it; <Tab>/<S-Tab>/<C-j>/<C-k> navigate
            auto_insert = false, -- wait for <CR> to insert
          },
        },

        -- ─── Menu ───────────────────────────────────────────────────────────
        menu = {
          border = "rounded", -- "none" | "single" | "double" | "rounded"
        },

        -- ─── Documentation popup ────────────────────────────────────────────
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },
      },
    },
  },
}
