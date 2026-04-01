return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
  opts = {
    preset = 'helix',
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = {
        Up = ' ',
        Down = ' ',
        Left = ' ',
        Right = ' ',
        C = '󰘴 ',
        M = '󰘵 ',
        D = '󰘳 ',
        S = '󰘶 ',
        CR = '󰌑 ',
        Esc = '󱊷 ',
        ScrollWheelDown = '󱕐 ',
        ScrollWheelUp = '󱕑 ',
        NL = '󰌑 ',
        BS = '󰁮',
        Space = '󱁐 ',
        Tab = '󰌒 ',
        F1 = '󱊫',
        F2 = '󱊬',
        F3 = '󱊭',
        F4 = '󱊮',
        F5 = '󱊯',
        F6 = '󱊰',
        F7 = '󱊱',
        F8 = '󱊲',
        F9 = '󱊳',
        F10 = '󱊴',
        F11 = '󱊵',
        F12 = '󱊶',
      },
    },

    -- Document existing key chains
    spec = {
      -- ── Existing groups ──────────────────────────────────────────────
      { '<leader>l', group = 'Lazy', icon = '󰒲 ' },
      { '<leader>s', group = '[S]earch', icon = ' ' },
      { '<leader>t', group = '[T]oggle', icon = ' ' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>b', group = '[B]uffer', icon = '󰓩 ' },
      { '<leader>w', group = '[W]indow', icon = ' ' },

      -- ── New groups (spec additions) ──────────────────────────────────
      { '<leader>f', group = '[F]ind / Format', icon = ' ' },
      { '<leader>g', group = '[G]it', icon = ' ' },
      { '<leader>x', group = 'Trouble / Di[x]', icon = ' ' },
      { '<leader>e', desc = 'Toggle Explorer', icon = ' ' },

      -- ── Explicit key descriptions (show correctly in which-key popup) ─
      -- Telescope
      { '<leader>ff', desc = 'Find Files' },
      { '<leader>fg', desc = 'Find by Grep' },
      { '<leader>fb', desc = 'Find Buffers' },
      { '<leader>fs', desc = 'Find LSP Symbols' },

      -- Git / Lazygit
      { '<leader>gg', desc = 'LazyGit', icon = ' ' },

      -- Trouble
      { '<leader>xx', desc = 'Diagnostics toggle', icon = ' ' },
      { '<leader>xX', desc = 'Buffer diagnostics toggle', icon = ' ' },
      { '<leader>xL', desc = 'Location list', icon = ' ' },
      { '<leader>xQ', desc = 'Quickfix list', icon = ' ' },

      -- LSP (set globally; LspAttach also sets them buffer-local)
      { '<leader>ca', desc = 'Code Action', icon = ' ' },
      { '<leader>rn', desc = 'Rename', icon = '󰑕 ' },
      { '<leader>gd', desc = 'Go to Definition', icon = ' ' },
      { '<leader>gr', desc = 'References', icon = ' ' },
      { '<leader>K', desc = 'Hover Docs', icon = ' ' },

      -- Format
      { '<leader>f', desc = 'Format Buffer', icon = '󰉢 ', mode = { 'n', 'v' } },

      -- Debug group kept from original
      { '<leader>x', group = '[D]ebug / Trouble', icon = ' ' },
    },
  },
}
