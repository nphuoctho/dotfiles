return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float", -- dùng floating window
      float_opts = {
        border = "curved", -- hoặc "single", "double", "shadow"
        -- width = 100,
        -- height = 25,
        -- winblend = 3, -- độ trong suốt
      },
      open_mapping = [[<C-\>]], -- phím mở terminal
      start_in_insert = true,
      persist_size = false,
    })
  end,
}
