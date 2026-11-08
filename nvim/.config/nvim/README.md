# Neovim configuration

Personal LazyVim configuration for TypeScript, Python, Go, C/C++, Docker, and infrastructure files.

## Language tooling

- **TypeScript/JavaScript:** TypeScript 7 native `tsc --lsp` (mason `tsc`) by default; `NVIM_TS_LSP=vtsls nvim` switches to VTSLS (has refactors). Prettier formats only where a prettier config exists, Oxfmt only with an oxfmt config; ESLint and Oxlint (syntactic mode) lint.
- **Python:** pyrefly (`NVIM_PY_LSP=basedpyright nvim` to switch) and Ruff.
- **Go:** gopls, goimports, goimports-reviser, gofumpt, templ, and Delve. No external linter (golangci-lint cannot read go1.27 export data yet).
- **C/C++:** clangd with clang-tidy and background indexing; falls back to `-std=c++23` without a compile database. Format-on-save only when a `.clang-format` exists up the tree.
- **Shell/Docker/Markdown:** bashls + shellcheck, hadolint, yamlls (compose files), markdownlint as linter only.

## Custom behavior

- `<leader>ci`, `<leader>cu`, `<leader>cA`, `<leader>cM`, and `<leader>cT` provide import and server actions (VTSLS commands or TS7 source actions, depending on the server).
- `<leader>cy` copies the highest-severity diagnostic on the current line.
- `<leader>cx` runs the current Python, Lua, shell, Zsh, Go, C, or C++ file in a terminal split (C/C++ with `-O2` and sanitizers).
- `<leader>dGt` / `<leader>dGl` debug the nearest / last Go test; `<leader>gF` opens Diffview file history; `<leader>uk` toggles Showkeys.
- `:SafeSource` only reloads the current buffer when it is Lua or Vimscript.

Update plugins with `:Lazy update`; inspect configured formatters with `:ConformInfo`.
