# Hotkey list

superfile hotkey list, mapped from `~/.config/yazi/keymap.toml`. Source of truth: `hotkeys.toml` in this directory.

## General

| Function                                | Key                   | Variable name       |
| --------------------------------------- | --------------------- | ------------------- |
| Open superfile                          | `spf`                 |                     |
| Confirm selected item                   | `enter`, `right`, `l` | `confirm`           |
| Quit typing, modal or superfile         | `q`, `esc`            | `quit`              |
| Quit superfile and cd to current folder | `Q`                   | `cd_quit`           |
| Confirm typing                          | `enter`               | `confirm_typing`    |
| Cancel typing                           | `ctrl+c`, `esc`       | `cancel_typing`     |
| Open help menu (hotkey list)            | `~`, `?`              | `open_help_menu`    |
| Open prompt in shell mode               | `:`, `;`              | `open_command_line` |
| Open prompt in spf mode                 | `>`                   | `open_spf_prompt`   |
| Open zoxide navigation modal            | `Z`, `z`              | `open_zoxide`       |

## Panel navigation

| Function                         | Key                            | Variable name               |
| -------------------------------- | ------------------------------ | --------------------------- |
| Create new file panel (at home)  | `n`                            | `create_new_file_panel`     |
| Split focused file panel         | `t`                            | `split_file_panel`          |
| Close the focused file panel     | `ctrl+c`                       | `close_file_panel`          |
| Toggle file preview panel        | `T` (shift+t)                  | `toggle_file_preview_panel` |
| Open sort options menu           | `,`                            | `open_sort_options_menu`    |
| Toggle reverse sort              | `R` (shift+r)                  | `toggle_reverse_sort`       |
| Toggle footer                    | `F` (shift+f)                  | `toggle_footer`             |
| Focus on the next file panel     | `]`, `tab`, `L` (shift+l)      | `next_file_panel`           |
| Focus on the previous file panel | `[`, `shift+tab`, `H` (shift+h) | `previous_file_panel`       |
| Focus on the processbar panel    | `w`                            | `focus_on_process_bar`      |
| Focus on the sidebar             | `s`                            | `focus_on_sidebar`          |
| Focus on the metadata panel      | `m`                            | `focus_on_metadata`         |

## Panel movement

| Function                                           | Key                         | Variable name                                                    |
| -------------------------------------------------- | --------------------------- | ---------------------------------------------------------------- |
| Up                                                 | `up`, `k`                   | `list_up`                                                        |
| Down                                               | `down`, `j`                 | `list_down`                                                      |
| Page up                                            | `ctrl+b`, `ctrl+u`          | `page_up`                                                        |
| Page down                                          | `ctrl+f`, `ctrl+d`          | `page_down`                                                      |
| Return to parent folder                            | `h`, `left`, `backspace`    | `parent_directory`                                               |
| Select all items in focused file panel             | `ctrl+a`                    | `file_panel_select_all_items` (selection mode only)              |
| Select up from your cursor                         | `shift+up`, `K` (shift+k)   | `file_panel_select_mode_items_select_up` (selection mode only)   |
| Select down from your cursor                       | `shift+down`, `J` (shift+j) | `file_panel_select_mode_items_select_down` (selection mode only) |
| Toggle dot file display                            | `.`                         | `toggle_dot_file`                                                |
| Toggle active search bar                           | `/`, `f`                    | `search_bar`                                                     |
| Change between selection mode or normal mode       | `v`                         | `change_panel_mode`                                              |
| Pin or Unpin folder to sidebar (can be auto saved) | `P` (shift+p)               | `pinned_directory`                                               |

## File operations

| Function                                              | Key                | Variable name                                      |
| ----------------------------------------------------- | ------------------ | -------------------------------------------------- |
| Create file or folder (end with / to create a folder) | `a`                | `file_panel_item_create`                           |
| Rename file or folder                                 | `r`                | `file_panel_item_rename`                           |
| Copy selected items to the clipboard                  | `y`                | `copy_items`                                       |
| Cut selected items to the clipboard                   | `x`                | `cut_items`                                        |
| Paste clipboard items into the current file panel     | `p`                | `paste_items`                                      |
| Delete selected items                                 | `d`, `delete`      | `delete_items`                                     |
| Permanently delete selected items                     | `D` (shift+d)      | `permanently_delete_items`                         |
| Copy current or selected file/directory paths         | `c`                | `copy_path`                                        |
| Copy current working directory                        | `Y` (shift+y)      | `copy_present_working_directory`                   |
| Extract compressed file                               | `ctrl+e`           | `extract_file` (normal mode)                       |
| Zip file or folder to .zip file                       | `C` (shift+c)      | `compress_file` (normal mode)                      |
| Open file with your default editor                    | `e`                | `open_file_with_editor` (normal mode)              |
| Open current directory with default editor            | `E` (shift+e)      | `open_current_directory_with_editor` (normal mode) |

## Yazi bindings without a superfile equivalent

superfile has no key chords, history, top/bottom jump or invert-selection action. These yazi bindings are not mapped.

| Yazi key                                   | Yazi function                       | Note                                                              |
| ------------------------------------------ | ----------------------------------- | ----------------------------------------------------------------- |
| `g g`, `G`                                 | Go to top / bottom                  | No action in superfile v1.6.0; cursor only wraps around           |
| `g h`, `g c`, `g d`, `g t`, `g <Space>`    | Goto directories                    | Use sidebar (`s`), pinned folders (`P`) or zoxide (`Z`)           |
| `m s/p/b/m/o/n`                            | Linemode                            | Use sort menu (`,`) or `file_panel_extra_columns` in config.toml  |
| `, m/b/e/a/n/s/r` (+ shift = reverse)      | Sort chords                         | Pick in sort menu (`,`), reverse with `R`                         |
| `c d`, `c f`, `c n`                        | Copy dirname / filename / name      | Only `c` (path) and `Y` (working directory)                       |
| `<Space>`                                  | Toggle selection                    | In selection mode `enter`/`l` toggles the item                    |
| `V`, `C-r`                                 | Visual unset / invert selection     | Not available                                                     |
| `H`, `L` (history)                         | Back / forward directory            | `H`/`L` switch panels instead                                     |
| `P`, `-`, `_`, `C--`, `Y`/`X`, `U`         | Force paste, links, unyank, restore | Not available (`P` pins a folder, `Y` copies the working directory) |
| `n`, `N`, `?` (find)                       | Find next / previous                | `n` creates a panel at home; `?` opens help                       |
| `o`, `O`, `S`, `!`, `<C-z>`                | Open, rg search, shell, suspend     | Not available (`z` is zoxide here, not fzf)                       |
| `g l`                                      | lazygit plugin                      | Not available                                                     |
