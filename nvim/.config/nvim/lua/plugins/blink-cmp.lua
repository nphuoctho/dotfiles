return {
  "Saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      menu = { border = "rounded", winblend = vim.o.pumblend },
      documentation = { window = { border = "rounded" } },
    },
    signature = { window = { border = "rounded" }, winblend = vim.o.pumblend },
    keymap = {
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
    cmdline = {
      keymap = {
        ["<Tab>"] = { "accept" },
        ["<CR>"] = { "accept_and_enter", "fallback" },
      },
      completion = {
        menu = { auto_show = true },
        ghost_text = {
          enabled = true,
        },
      },
    },
  },
}
