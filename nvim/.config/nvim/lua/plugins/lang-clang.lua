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
            "--function-arg-placeholders=1", -- bare flag is rejected by clangd >= 22 ("Provide a boolean")
            "--fallback-style=llvm",
            "--log=error", -- default --log=info floods lsp.log (4 lines per completion)
            -- add for big projects:
            -- "--limit-results=20",
            -- "--pch-storage=memory",
          },
          init_options = {
            clangdFileStatus = true,
            -- Only used when there is no compile_commands.json/compile_flags.txt (standalone DSA files);
            -- clangd's default is gnu++17, so std::ranges / std::format were "undeclared".
            fallbackFlags = { "-std=c++23" },
          },
          -- pin offset encoding to silence the mismatch warning
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
        },
      },
    },
  },
}
