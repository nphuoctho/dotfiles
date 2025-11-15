return {
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    enabled = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local bufferline = require 'bufferline'
      bufferline.setup {
        options = {
          -- mode = 'buffers',
          -- themable = true,
          diagnostics = 'nvim_lsp',
          separator_style = 'thick',
          show_close_icon = true,
          show_buffer_close_icons = false,
          always_show_bufferline = false,
          color_icons = true,

          max_name_length = 24,
          max_prefix_length = 24,
          tab_size = 20,
        },
      }

      -- Keymap
      local map = vim.keymap.set

      -- Switch buffer
      map('n', '<Tab>', '<CMD>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
      map('n', '<S-Tab>', '<CMD>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })

      -- Close buffers
      map('n', '<leader>bc', '<CMD>bdelete<CR>', { desc = 'Close current buffer' })
      map('n', '<leader>bo', '<CMD>BufferLineCloseOthers<CR>', { desc = 'Close other buffers' })
      map('n', '<leader>bl', '<CMD>BufferLineCloseLeft<CR>', { desc = 'Close left buffers' })
      map('n', '<leader>br', '<CMD>BufferLineCloseRight<CR>', { desc = 'Close right buffers' })

      -- Pin & pick
      map('n', '<leader>bp', '<CMD>BufferLineTogglePin<CR>', { desc = 'Pin buffer' })
      map('n', '<leader>bP', '<CMD>BufferLinePick<CR>', { desc = 'Pick buffer by letter' })

      -- Move buffers
      map('n', '<leader>bm', '<CMD>BufferLineMoveNext<CR>', { desc = 'Move buffer right' })
      map('n', '<leader>bM', '<CMD>BufferLineMovePrev<CR>', { desc = 'Move buffer left' })
    end,
  },
}

