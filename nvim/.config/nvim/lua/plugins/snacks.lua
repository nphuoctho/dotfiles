return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    -- Animated <C-d>/<C-u>/zz scrolling blocks the view for the whole animation:
    -- ~270-550 ms per half-page jump and ~130-190 ms of CPU. Native 'smoothscroll' stays on.
    scroll = { enabled = false },

    dashboard = {
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
    },

    styles = {
      lazygit = {
        border = "rounded",
      },
    },
  },
}
