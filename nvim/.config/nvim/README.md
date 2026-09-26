# Neovim configuration

Personal LazyVim configuration for TypeScript, Python, Go, C/C++, Docker, and infrastructure files.

## Language tooling

- **TypeScript/JavaScript:** VTSLS for language features; Prettier and Oxfmt format; ESLint and Oxlint provide linting.
- **Python:** basedpyright and Ruff, with a project `.venv` selected when available.
- **Go:** gopls, goimports-reviser, gofumpt, templ, Delve, and golangci-lint.
- **C/C++:** clangd with clang-tidy and background indexing.

## Custom behavior

- `<leader>ci`, `<leader>cu`, `<leader>cA`, and `<leader>cT` provide VTSLS import and server actions.
- `<leader>cy` copies the highest-severity diagnostic on the current line.
- `<leader>cx` runs the current Python, Lua, shell, Zsh, or Go file in a terminal split.
- `:SafeSource` only reloads the current buffer when it is Lua or Vimscript.

Update plugins with `:Lazy update`; inspect configured formatters with `:ConformInfo`.
