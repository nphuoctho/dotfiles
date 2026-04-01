return {
  -- ── mini.nvim: ai textobjects + surround ────────────────────────────────
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
    end,
  },

  -- ── noice.nvim + nvim-notify: modern UI ─────────────────────────────────
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      {
        'rcarriga/nvim-notify',
        opts = {
          background_colour = '#1a1b26', -- tokyonight-night bg color
          timeout = 3000,
          max_width = 60,
          render = 'wrapped-compact',
          stages = 'fade',
        },
      },
    },
    config = function()
      vim.notify = require 'notify'
      require('noice').setup {
        cmdline = {
          enabled = true,
          view = 'cmdline_popup',
          opts = {},
          format = {
            cmdline = { pattern = '^:', icon = '', lang = 'vim' },
            search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
            search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
            filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
            lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = ' ', lang = 'lua' },
            help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
            input = { view = 'cmdline_input', icon = '󰥻 ' },
          },
        },
        messages = {
          enabled = true,
          view = 'notify',
          view_error = 'notify',
          view_warn = 'notify',
          view_history = 'messages',
          view_search = 'virtualtext',
        },
        popupmenu = {
          enabled = true,
          backend = 'nui',
          kind_icons = {},
        },
        redirect = {
          view = 'popup',
          filter = { event = 'msg_show' },
        },
        commands = {
          history = {
            view = 'split',
            opts = { enter = true, format = 'details' },
            filter = {
              any = {
                { event = 'notify' },
                { error = true },
                { warning = true },
                { event = 'msg_show', kind = { '' } },
                { event = 'lsp', kind = 'message' },
              },
            },
          },
          last = {
            view = 'popup',
            opts = { enter = true, format = 'details' },
            filter = {
              any = {
                { event = 'notify' },
                { error = true },
                { warning = true },
                { event = 'msg_show', kind = { '' } },
                { event = 'lsp', kind = 'message' },
              },
            },
            filter_opts = { count = 1 },
          },
          errors = {
            view = 'popup',
            opts = { enter = true, format = 'details' },
            filter = { error = true },
            filter_opts = { reverse = true },
          },
          all = {
            view = 'split',
            opts = { enter = true, format = 'details' },
            filter = {},
          },
        },
        notify = {
          enabled = true,
          view = 'notify',
        },
        lsp = {
          progress = {
            enabled = true,
            format = 'lsp_progress',
            format_done = 'lsp_progress_done',
            throttle = 1000 / 30,
            view = 'mini',
          },
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = false,
            ['vim.lsp.util.stylize_markdown'] = false,
            ['cmp.entry.get_documentation'] = false,
          },
          hover = {
            enabled = true,
            silent = false,
            view = nil,
            opts = {},
          },
          signature = {
            enabled = true,
            auto_open = {
              enabled = true,
              trigger = true,
              luasnip = true,
              throttle = 50,
            },
            view = nil,
            opts = {},
          },
          message = {
            enabled = true,
            view = 'notify',
            opts = {},
          },
          documentation = {
            view = 'hover',
            opts = {
              lang = 'markdown',
              replace = true,
              render = 'plain',
              format = { '{message}' },
              win_options = { concealcursor = 'n', conceallevel = 3 },
            },
          },
        },
        health = { checker = true },
        presets = {
          bottom_search = false,
          command_palette = false,
          long_message_to_split = false,
          inc_rename = false,
          lsp_doc_border = false,
        },
        throttle = 1000 / 30,
        views = {},
        routes = {},
        status = {},
        format = {},
      }
    end,
  },

  -- ── alpha-nvim: dashboard ────────────────────────────────────────────────
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.header.val = {
        [[<-. (`-')_  (`-')  _                 (`-')  _     <-. (`-')  ]],
        [[   \( OO) ) ( OO).-/     .->        _(OO ) (_)       \(OO )_ ]],
        [[,--./ ,--/ (,------.(`-')----. ,--.(_/,-.\ ,-(`-'),--./  ,-.)]],
        [[|   \ |  |  |  .---'( OO).-.  '\   \ / (_/ | ( OO)|   `.'   |]],
        [[|  . '|  |)(|  '--. ( _) | |  | \   /   /  |  |  )|  |'.'|  |]],
        [[|  |\    |  |  .--'  \|  |)|  |_ \     /_)(|  |_/ |  |   |  |]],
        [[|  | \   |  |  `---.  '  '-'  '\-'\   /    |  |'->|  |   |  |]],
        [[`--'  `--'  `------'   `-----'     `-'     `--'   `--'   `--']],
      }

      dashboard.section.buttons.val = {
        dashboard.button('i', '  New file', ':enew<CR>'),
        dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
        dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
        dashboard.button('g', '  Find text', ':Telescope live_grep<CR>'),
        dashboard.button('l', '󰒲  Lazy', ':Lazy<CR>'),
        dashboard.button('h', '  Check health', ':checkhealth<CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      dashboard.section.footer.val = "Don't Stop Until You are Proud..."
      alpha.setup(dashboard.opts)
    end,
  },

  -- ── lualine: statusline ──────────────────────────────────────────────────
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local diffColors = { added = '#9ECE6A', modified = '#7AA2F7', removed = '#F7768E' }

      require('lualine').setup {
        options = {
          theme = 'auto',
          icons_enabled = true,
          globalstatus = true,
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        },
        extensions = { 'quickfix', 'fugitive' },
        sections = {
          lualine_a = {
            {
              function()
                return ''
              end,
              padding = { left = 1, right = 0 },
              separator = { left = '' },
            },
            { 'mode', separator = { right = '' } },
          },
          lualine_b = { { 'branch', icon = '' } },
          lualine_c = {
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            },
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            {
              'filename',
              path = 1,
              shorting_target = 32,
              file_status = true,
              padding = { left = 0 },
              symbols = { modified = '●', readonly = '', unnamed = '[No Name]', newfile = '' },
            },
          },
          lualine_x = {
            {
              'diff',
              colored = true,
              symbols = { added = ' ', modified = ' ', removed = ' ' },
              diff_color = {
                added = { fg = diffColors.added },
                modified = { fg = diffColors.modified },
                removed = { fg = diffColors.removed },
              },
            },
          },
          lualine_y = {
            { 'location', separator = '' },
            {
              function()
                return ''
              end,
              padding = { left = 0, right = 1 },
            },
          },
          lualine_z = {
            {
              function()
                return ' ' .. os.date '%R'
              end,
              separator = { left = '', right = '' },
            },
          },
        },
      }
    end,
  },
}
