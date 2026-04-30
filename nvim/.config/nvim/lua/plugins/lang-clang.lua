return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            -- Thêm nếu project lớn:
            -- "--limit-results=20",
            -- "--pch-storage=memory",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          -- Fix offset encoding để tránh warning
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
        },
      },
    },
  },
}
