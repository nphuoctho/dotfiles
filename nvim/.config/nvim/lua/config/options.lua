-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- This config runs on a local PC; use the native desktop clipboard.
vim.opt.clipboard = "unnamedplus"

-- TypeScript LSP: "vtsls" (stable) or "tsgo" (~10x faster, still experimental).
-- Stick with vtsls unless the monorepo is huge.
vim.g.lazyvim_ts_lsp = "vtsls"

-- Python LSP: "pyright" (default) or "basedpyright" (stricter community fork).
-- Pick basedpyright if you want real type checking.
vim.g.lazyvim_python_lsp = "basedpyright"

-- Ruff: replaces flake8 + black + isort.
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "blink.cmp"
