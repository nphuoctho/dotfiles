-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- TypeScript LSP: "vtsls" (default, stable) hoặc "tsgo" (mới hơn, nhanh hơn ~10x)
-- tsgo vẫn experimental, dùng vtsls trừ khi monorepo rất lớn
vim.g.lazyvim_ts_lsp = "vtsls"

-- Python LSP: "pyright" (default) hoặc "basedpyright" (strict hơn, community fork)
-- basedpyright recommended nếu cần type checking nghiêm ngặt
vim.g.lazyvim_python_lsp = "basedpyright"

-- Ruff: modern Python linter+formatter (thay thế flake8/black/isort)
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_picker = "telescope"

vim.g.lazyvim_cmp = "blink.cmp"
