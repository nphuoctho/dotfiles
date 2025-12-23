# Yazi keymap cheat-sheet

> Note: Yazi has many **default** key bindings that depend on the Yazi version.
> You can always see the built-in defaults inside Yazi via the help panel.

## Custom keymaps (from `keymap.toml`)

### Git

| Keys  | Action       | Runs             |
| ----- | ------------ | ---------------- |
| `g i` | Open lazygit | `plugin lazygit` |

### Trash / Recycle Bin

| Keys  | Action                            | Runs                           |
| ----- | --------------------------------- | ------------------------------ |
| `g t` | Go to Trash directory             | `plugin recycle-bin open`      |
| `R o` | Open Trash directory              | `plugin recycle-bin open`      |
| `R r` | Restore selected items            | `plugin recycle-bin restore`   |
| `R d` | Permanently delete selected items | `plugin recycle-bin delete`    |
| `R e` | Empty the entire Trash            | `plugin recycle-bin empty`     |
| `R D` | Empty items older than N days     | `plugin recycle-bin emptyDays` |

### Archive / Compression

| Keys    | Action                              | Runs                   |
| ------- | ----------------------------------- | ---------------------- |
| `c a a` | Archive selected files              | `plugin compress`      |
| `c a p` | Archive (password)                  | `plugin compress -p`   |
| `c a h` | Archive (password + header)         | `plugin compress -ph`  |
| `c a l` | Archive (compression level)         | `plugin compress -l`   |
| `c a u` | Archive (password + header + level) | `plugin compress -phl` |
| `C`     | Compress with ouch                  | `plugin ouch`          |

### Utilities

| Keys  | Action                          | Runs               |
| ----- | ------------------------------- | ------------------ |
| `c s` | Calculate size of selection/cwd | `plugin what-size` |
| `c m` | Chmod selected files            | `plugin chmod`     |

## Notes

- Permanent delete in Trash requires selecting files first (e.g. `Space` to toggle select).
- Archive extract-on-Enter is configured in `yazi.toml` via `[open].rules` using the `extract` opener.


## Default keybindings

This is a practical subset summarized from: https://yazi-rs.github.io/docs/quick-start

Because defaults can change across releases, treat this as a reference — if something differs on your system, open Yazi help.

### Help / Quit

| Keys        | Action          |
| ----------- | --------------- |
| `q`         | Quit            |
| `F1` or `~` | Open help panel |

### Navigation

| Keys      | Action                      |
| --------- | --------------------------- |
| `↑` / `k` | Move up                     |
| `↓` / `j` | Move down                   |
| `→` / `l` | Enter hovered directory     |
| `←` / `h` | Go to parent directory      |
| `g g`     | Jump to top                 |
| `G`       | Jump to bottom              |
| `K`       | Seek up (preview)           |
| `J`       | Seek down (preview)         |
| `z`       | Jump via fzf (cd/reveal)    |
| `Z`       | Jump via zoxide             |
| `g Space` | Jump via interactive prompt |

### Selection

| Keys     | Action                     |
| -------- | -------------------------- |
| `Space`  | Toggle selection (hovered) |
| `v`      | Visual selection mode      |
| `V`      | Visual unset mode          |
| `Ctrl+a` | Select all                 |
| `Ctrl+r` | Invert selection           |
| `Esc`    | Cancel selection           |

### File operations

| Keys          | Action                                               |
| ------------- | ---------------------------------------------------- |
| `Enter`       | Open selected files                                  |
| `Shift+Enter` | Open interactively (terminal support may vary)       |
| `o`           | Open                                                 |
| `O`           | Open interactively                                   |
| `Tab`         | Show file information                                |
| `y`           | Yank (copy)                                          |
| `x`           | Yank (cut)                                           |
| `p`           | Paste                                                |
| `P`           | Paste (overwrite if exists)                          |
| `Y` / `X`     | Cancel yank status                                   |
| `d`           | Trash selected files                                 |
| `D`           | Permanently delete selected files                    |
| `a`           | Create file (use trailing `/` to create a directory) |
| `r`           | Rename                                               |
| `.`           | Toggle hidden files                                  |
| `;`           | Run a shell command                                  |
| `:`           | Run a shell command (block until finished)           |

### Copy paths

| Keys  | Action                       |
| ----- | ---------------------------- |
| `c c` | Copy file path               |
| `c d` | Copy directory path          |
| `c f` | Copy filename                |
| `c n` | Copy filename (no extension) |

### Filter / Find / Search

| Keys     | Action                      |
| -------- | --------------------------- |
| `f`      | Filter files                |
| `/`      | Find next                   |
| `?`      | Find previous               |
| `n`      | Next match                  |
| `N`      | Previous match              |
| `s`      | Search by name (fd)         |
| `S`      | Search by content (ripgrep) |
| `Ctrl+s` | Cancel search               |

### Sorting

| Keys          | Action                                   |
| ------------- | ---------------------------------------- |
| `, a` / `, A` | Sort alphabetically (normal / reverse)   |
| `, n` / `, N` | Sort naturally (normal / reverse)        |
| `, s` / `, S` | Sort by size (normal / reverse)          |
| `, m` / `, M` | Sort by modified time (normal / reverse) |
| `, e` / `, E` | Sort by extension (normal / reverse)     |
| `, r`         | Sort randomly                            |

### Tabs

| Keys      | Action                        |
| --------- | ----------------------------- |
| `t`       | New tab (current directory)   |
| `1` … `9` | Switch to N-th tab            |
| `[` / `]` | Previous / next tab           |
| `{` / `}` | Swap tab with previous / next |
| `Ctrl+c`  | Close current tab             |
