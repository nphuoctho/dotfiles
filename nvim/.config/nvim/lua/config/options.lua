-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- This config runs on a local PC; use the native desktop clipboard.
vim.opt.clipboard = "unnamedplus"

-- TypeScript LSP: "tsc" (TS7 native `tsc --lsp`, default) or "vtsls" (VS Code ts extension wrapper).
-- tsc: first completion ~1s, no queueing behind inlayHint/semanticTokens; lacks refactor code actions.
-- vtsls: has refactors (extract/move) but tsserver cold start is 3-12s. Override: `NVIM_TS_LSP=vtsls nvim`.
vim.g.lazyvim_ts_lsp = (vim.env.NVIM_TS_LSP and vim.env.NVIM_TS_LSP ~= "") and vim.env.NVIM_TS_LSP or "tsc"

-- Python LSP: "pyrefly" (default) or "basedpyright" (`NVIM_PY_LSP=basedpyright nvim`).
-- Measured on real uv projects: pyrefly attaches in ~5 ms (basedpyright ~180 ms), cold first completion
-- 70-580 ms (1.1-1.8 s), RSS ~180-280 MB (~600 MB), and it offers auto-imports (`from fastapi import
-- FastAPI`, `import pandas as pd`) that basedpyright never does for packages no open file imports.
-- Costs: more background CPU on >50-file projects, cross-file rename/references incomplete for ~8 s
-- after opening, bundled .pyi go-to-definition for pandas.
vim.g.lazyvim_python_lsp = (vim.env.NVIM_PY_LSP and vim.env.NVIM_PY_LSP ~= "") and vim.env.NVIM_PY_LSP or "pyrefly"

-- Ruff: replaces flake8 + black + isort.
vim.g.lazyvim_python_ruff = "ruff"

-- Run prettier only where a prettier config exists (it reflowed compose files and markdown notes).
vim.g.lazyvim_prettier_needs_config = true

vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "blink.cmp"

-- Keep navic as the only breadcrumb source. LazyVim's default trouble symbols statusline
-- re-filters every document symbol on each cursor move (largest self-time in :profile of
-- plain `j` in a 4k-line TS file) and, while enabled, the navic extra's lualine component is skipped.
vim.g.trouble_lualine = false
