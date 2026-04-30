return {
  -- Show Keys
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- Hides the close icon for each individual buffer
        show_buffer_close_icons = false,
        -- Hides the main close icon in the top right corner
        show_close_icon = false,
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_a = { { "mode", icon = "" } }
      opts.sections.lualine_b = { { "branch", icon = "" } }
      opts.sections.lualine_y = { { "location", padding = { left = 0, right = 1 } } }

      return opts
    end,
  },
}
