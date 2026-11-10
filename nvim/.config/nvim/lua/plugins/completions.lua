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
        ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" }, -- item 1 is preselected, so Tab accepts instead of skipping to item 2
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
          show_in_snippet = true, -- keep the popup inside snippet placeholders (e.g. vtsls completeFunctionCalls args)
        },

        list = {
          selection = {
            preselect = true, -- auto-select first item; <C-j>/<C-k> navigate, <Tab>/<CR> accept
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
