-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- This config runs on a local PC; use the native desktop clipboard.
vim.opt.clipboard = "unnamedplus"

-- TypeScript LSP: "tsc" (TS7 native `tsc --lsp`, default) or "vtsls" (VS Code ts extension wrapper).
-- tsc: first completion ~1s, no queueing behind inlayHint/semanticTokens; lacks refactor code actions.
-- vtsls: has refactors (extract/move) but tsserver cold start is 3-12s. Override: `NVIM_TS_LSP=vtsls nvim`.
vim.g.lazyvim_ts_lsp = (vim.env.NVIM_TS_LSP and vim.env.NVIM_TS_LSP ~= "") and vim.env.NVIM_TS_LSP or "tsc"

-- Python LSP: "pyright" (default) or "basedpyright" (stricter community fork).
-- Pick basedpyright if you want real type checking.
vim.g.lazyvim_python_lsp = "basedpyright"

-- Ruff: replaces flake8 + black + isort.
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "blink.cmp"
