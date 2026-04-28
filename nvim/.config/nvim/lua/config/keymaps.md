# Neovim Keymaps

## Leader Keys

### General
| Key | Action | Description |
|-----|--------|-------------|
| `<leader><space>` | `Snacks.picker.smart()` | Smart Find Files |
| `<leader>,` | `Snacks.picker.buffers()` | Buffers |
| `<leader>/` | `Snacks.picker.grep()` | Grep |
| `<leader>:` | `Snacks.picker.command_history()` | Command History |
| `<leader>n` | `Snacks.picker.notifications()` | Notification History |
| `<leader>e` | `Snacks.explorer()` | File Explorer |
| `<leader>.` | `Snacks.scratch()` | Scratch Buffer |
| `<leader>S` | `Snacks.scratch.select()` | Scratch Select |
| `<leader>z` | `Snacks.zen()` | Zen Mode |
| `<leader>Z` | `Snacks.zen.zoom()` | Zoom |
| `<leader>?` | `which-key.show()` | Show Keymaps |

### Split & Terminal
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>sv` | `:vsplit` | Split Vertical |
| `<leader>sh` | `:split` | Split Horizontal |
| `<leader>tf` | `Snacks.terminal()` | Terminal (file dir) |
| `<C-/>` | `Snacks.terminal()` | Terminal |

### Buffer
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>bd` | `:bdelete` | Delete Buffer |
| `<S-h>` | `:bprev` | Previous Buffer |
| `<S-l>` | `:bnext` | Next Buffer |

### Quickfix
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>qo` | `:copen` | Quickfix Open |
| `<leader>qc` | `:cclose` | Quickfix Close |
| `]q` | `:cnext` | Next Quickfix |
| `[q` | `:cprev` | Previous Quickfix |

---

## Find (`<leader>f`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>fb` | `Snacks.picker.buffers()` | Buffers |
| `<leader>fc` | `Snacks.picker.files()` | Find Config File |
| `<leader>ff` | `Snacks.picker.files()` | Find Files |
| `<leader>fg` | `Snacks.picker.git_files()` | Find Git Files |
| `<leader>fp` | `Snacks.picker.projects()` | Projects |
| `<leader>fr` | `Snacks.picker.recent()` | Recent |

---

## Git (`<leader>g`)

### General
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gg` | `Snacks.lazygit()` | Lazygit |
| `<leader>gb` | `Snacks.picker.git_branches()` | Git Branches |
| `<leader>gl` | `Snacks.picker.git_log()` | Git Log |
| `<leader>gL` | `Snacks.picker.git_log_line()` | Git Log Line |
| `<leader>gs` | `Snacks.picker.git_status()` | Git Status |
| `<leader>gS` | `Snacks.picker.git_stash()` | Git Stash |
| `<leader>gd` | `Snacks.picker.git_diff()` | Git Diff (Hunks) |
| `<leader>gf` | `Snacks.picker.git_log_file()` | Git Log File |

### GitHub
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gi` | `Snacks.picker.gh_issue()` | GitHub Issues (open) |
| `<leader>gI` | `Snacks.picker.gh_issue()` | GitHub Issues (all) |
| `<leader>gp` | `Snacks.picker.gh_pr()` | GitHub PRs (open) |
| `<leader>gP` | `Snacks.picker.gh_pr()` | GitHub PRs (all) |

### Git Browse
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gB` | `Snacks.gitbrowse()` | Git Browse |

---

## Hunk (`<leader>h`)
| Key | Action | Description |
|-----|--------|-------------|
| `]h` | `gs.next_hunk()` | Next Hunk |
| `[h` | `gs.prev_hunk()` | Previous Hunk |
| `<leader>hs` | `gs.stage_hunk()` | Stage Hunk |
| `<leader>hr` | `gs.reset_hunk()` | Reset Hunk |
| `<leader>hS` | `gs.stage_buffer()` | Stage Buffer |
| `<leader>hR` | `gs.reset_buffer()` | Reset Buffer |
| `<leader>hp` | `gs.preview_hunk()` | Preview Hunk |
| `<leader>hb` | `gs.blame_line()` | Blame Line |
| `<leader>hd` | `gs.diffthis()` | Diff This |

---

## Search / Grep (`<leader>s`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>sb` | `Snacks.picker.lines()` | Buffer Lines |
| `<leader>sB` | `Snacks.picker.grep_buffers()` | Grep Open Buffers |
| `<leader>sg` | `Snacks.picker.grep()` | Grep |
| `<leader>sw` | `Snacks.picker.grep_word()` | Word/Selection |
| `<leader>s"` | `Snacks.picker.registers()` | Registers |
| `<leader>s/` | `Snacks.picker.search_history()` | Search History |
| `<leader>sa` | `Snacks.picker.autocmds()` | Autocmds |
| `<leader>sc` | `Snacks.picker.command_history()` | Command History |
| `<leader>sC` | `Snacks.picker.commands()` | Commands |
| `<leader>sd` | `Snacks.picker.diagnostics()` | Diagnostics |
| `<leader>sD` | `Snacks.picker.diagnostics_buffer()` | Buffer Diagnostics |
| `<leader>sh` | `Snacks.picker.help()` | Help Pages |
| `<leader>sH` | `Snacks.picker.highlights()` | Highlights |
| `<leader>si` | `Snacks.picker.icons()` | Icons |
| `<leader>sj` | `Snacks.picker.jumps()` | Jumps |
| `<leader>sk` | `Snacks.picker.keymaps()` | Keymaps |
| `<leader>sl` | `Snacks.picker.loclist()` | Location List |
| `<leader>sm` | `Snacks.picker.marks()` | Marks |
| `<leader>sM` | `Snacks.picker.man()` | Man Pages |
| `<leader>sp` | `Snacks.picker.lazy()` | Lazy Plugins |
| `<leader>sq` | `Snacks.picker.qflist()` | Quickfix List |
| `<leader>sR` | `Snacks.picker.resume()` | Resume |
| `<leader>su` | `Snacks.picker.undo()` | Undo History |

---

## LSP (`<leader>s` + `s`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ss` | `Snacks.picker.lsp_symbols()` | LSP Symbols |
| `<leader>sS` | `Snacks.picker.lsp_workspace_symbols()` | Workspace Symbols |

---

## Code (`<leader>c`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ca` | `vim.lsp.buf.code_action()` | Code Action |
| `<leader>rn` | `vim.lsp.buf.rename()` | Rename Symbol |
| `<leader>ds` | `vim.lsp.buf.document_symbol()` | Document Symbols |
| `<leader>cd` | `vim.diagnostic.open_float()` | Show Diagnostic |
| `<leader>cR` | `Snacks.rename.rename_file()` | Rename File |

---

## Toggle (`<leader>t`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tb` | `gs.toggle_current_line_blame()` | Toggle Blame |

---

## UI (`<leader>u`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>uC` | `Snacks.picker.colorschemes()` | Colorschemes |
| `<leader>un` | `Snacks.notifier.hide()` | Dismiss Notifications |
| `<leader>sn` | `Snacks.notifier.show_history()` | Notification History |

---

## LSP Navigation (Non-Leader)

### Goto
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | `Snacks.picker.lsp_definitions()` | Goto Definition |
| `gD` | `Snacks.picker.lsp_declarations()` | Goto Declaration |
| `gr` | `Snacks.picker.lsp_references()` | References |
| `gI` | `Snacks.picker.lsp_implementations()` | Goto Implementation |
| `gy` | `Snacks.picker.lsp_type_definitions()` | Type Definition |
| `gai` | `Snacks.picker.lsp_incoming_calls()` | Incoming Calls |
| `gao` | `Snacks.picker.lsp_outgoing_calls()` | Outgoing Calls |

### Hover
| Key | Action | Description |
|-----|--------|-------------|
| `K` | `vim.lsp.buf.hover()` | Hover Docs |

### Diagnostic Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `]d` | `vim.diagnostic.jump()` | Next Error |
| `[d` | `vim.diagnostic.jump()` | Prev Error |

---

## Text Objects (Snacks Scope)
| Key | Action | Description |
|-----|--------|-------------|
| `ii` | `Snacks.scope.textobject()` | Inner Scope (inner) |
| `ai` | `Snacks.scope.textobject()` | Outer Scope (around) |
| `[i` | `Snacks.scope.jump("up")` | Jump to Scope Start |
| `]i` | `Snacks.scope.jump("down")` | Jump to Scope End |
| `]]` | `Snacks.words.jump()` | Next Reference |
| `[[` | `Snacks.words.jump()` | Prev Reference |

---

## General Keys (No Leader)

### Insert Mode
| Key | Action | Description |
|-----|--------|-------------|
| `jk` | `<Esc>` | Exit Insert Mode |

### Search
| Key | Action | Description |
|-----|--------|-------------|
| `n` | `nzzzv` | Next Search (centered) |
| `N` | `Nzzzv` | Prev Search (centered) |
| `<Esc>` | `:nohlsearch` | Clear Search Highlight |

### Scroll
| Key | Action | Description |
|-----|--------|-------------|
| `<C-d>` | `<C-d>zz` | Scroll Down (centered) |
| `<C-u>` | `<C-u>zz` | Scroll Up (centered) |

### Window Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `<C-h>` | `<C-w>h` | Go Left Window |
| `<C-j>` | `<C-w>j` | Go Bottom Window |
| `<C-k>` | `<C-w>k` | Go Top Window |
| `<C-l>` | `<C-w>l` | Go Right Window |

### Resize
| Key | Action | Description |
|-----|--------|-------------|
| `<C-Up>` | `:resize +2` | Increase Height |
| `<C-Down>` | `:resize -2` | Decrease Height |
| `<C-Left>` | `:vertical resize -2` | Decrease Width |
| `<C-Right>` | `:vertical resize +2` | Increase Width |

### Line Movement
| Key | Action | Description |
|-----|--------|-------------|
| `<A-j>` | `:m .+1` | Move Line Down |
| `<A-k>` | `:m .-2` | Move Line Up |
| `<A-j>` (v) | `:m '>+1` | Move Selection Down |
| `<A-k>` (v) | `:m '<-2` | Move Selection Up |