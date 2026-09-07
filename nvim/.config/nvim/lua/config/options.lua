-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Keep clipboard behavior correct in both local and SSH sessions.
-- Over SSH, OSC 52 sends yanks to the terminal on the client machine;
-- xclip would otherwise target the remote DISPLAY.
if vim.env.SSH_CONNECTION then
  vim.g.clipboard = "osc52"
end
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
