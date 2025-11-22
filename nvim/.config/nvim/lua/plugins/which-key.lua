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
        Up = ' ',
        Down = ' ',
        Left = ' ',
        Right = ' ',
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
      { '<leader>l', group = 'Lazy', icon = '󰒲 ' },
      { '<leader>s', group = '[S]earch', icon = ' ' },
      { '<leader>t', group = '[T]oggle', icon = ' ' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>b', group = '[B]uffer', icon = '󰓩 ' },
      { '<leader>w', group = '[W]indow', icon = ' ' },
      { '<leader>x', group = '[D]ebug', icon = ' ' },
    },
  },
}
