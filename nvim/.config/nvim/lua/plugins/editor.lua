return {
  -- Auto close tags
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },

  -- Auto pairs + qoutes
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Blankline indent
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- Venv Selector
  {
    'linux-cultist/venv-selector.nvim',
    opts = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
    ft = 'python',
    keys = {
      { ',vs', '<cmd>VenvSelect<cr>', desc = 'Select VirtualEnv', ft = 'python' },
    },
  },

  -- Code Runner
  -- {
  --   'stevearc/overseer.nvim',
  --   opts = {},
  -- },
}
