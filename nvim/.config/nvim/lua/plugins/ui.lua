---@type LazySpec
return {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- load trước tất cả plugins khác
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "tokyonight",
          component_separators = "|",
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
      }
    end,
  },

  -- Icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      -- Override vim.web_devicons API (compat cho plugins cũ)
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- Keybind hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    ---@class wk.Opts
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "helix",
      --- You can add any mappings here, or use `require('which-key').add()` later
      ---@type wk.Spec
      spec = {
        { "<leader><space>", group = "Smart Find" },
        { "<leader>,", group = "Buffers" },
        { "<leader>/", group = "Grep" },
        { "<leader>:", group = "Command History" },
        { "<leader>.", group = "Scratch" },
        { "<leader>n", group = "Notifications" },
        { "<leader>e", group = "Explorer" },
        { "<leader>z", group = "Zen" },
        { "<leader>Z", group = "Zoom" },
        { "<leader>S", group = "Scratch Select" },
        { "<leader>u", group = "UI" },
        -- find
        { "<leader>fb", group = "Find Buffers" },
        { "<leader>fc", group = "Find Config" },
        { "<leader>ff", group = "Find Files" },
        { "<leader>fg", group = "Find Git" },
        { "<leader>fp", group = "Find Projects" },
        { "<leader>fr", group = "Find Recent" },
        -- git
        { "<leader>gb", group = "Git Branches" },
        { "<leader>gl", group = "Git Log" },
        { "<leader>gL", group = "Git Log Line" },
        { "<leader>gs", group = "Git Status" },
        { "<leader>gS", group = "Git Stash" },
        { "<leader>gd", group = "Git Diff" },
        { "<leader>gf", group = "Git Log File" },
        -- gh
        { "<leader>gi", group = "GitHub Issues" },
        { "<leader>gI", group = "GitHub Issues (all)" },
        { "<leader>gp", group = "GitHub PRs" },
        { "<leader>gP", group = "GitHub PRs (all)" },
        -- search/grep
        { "<leader>sb", group = "Search Buffer" },
        { "<leader>sB", group = "Search Buffers" },
        { "<leader>sg", group = "Search Grep" },
        { "<leader>sw", group = "Search Word" },
        { "<leader>s\"", group = "Search Registers" },
        { "<leader>s/", group = "Search History" },
        { "<leader>sa", group = "Search Autocmds" },
        { "<leader>sc", group = "Search Commands" },
        { "<leader>sC", group = "Search Commands All" },
        { "<leader>sd", group = "Search Diagnostics" },
        { "<leader>sD", group = "Search Diagnostics Buf" },
        { "<leader>sh", group = "Search Help" },
        { "<leader>sH", group = "Search Highlights" },
        { "<leader>si", group = "Search Icons" },
        { "<leader>sj", group = "Search Jumps" },
        { "<leader>sk", group = "Search Keymaps" },
        { "<leader>sl", group = "Search Loclist" },
        { "<leader>sm", group = "Search Marks" },
        { "<leader>sM", group = "Search Man" },
        { "<leader>sp", group = "Search Plugin" },
        { "<leader>sq", group = "Search Quickfix" },
        { "<leader>sR", group = "Search Resume" },
        { "<leader>su", group = "Search Undo" },
        { "<leader>sS", group = "Search Symbols" },
        { "<leader>ss", group = "LSP Symbols" },
        -- hunk
        { "<leader>hs", group = "Hunk Stage" },
        { "<leader>hr", group = "Hunk Reset" },
        { "<leader>hS", group = "Hunk Stage Buffer" },
        { "<leader>hR", group = "Hunk Reset Buffer" },
        { "<leader>hp", group = "Hunk Preview" },
        { "<leader>hb", group = "Hunk Blame" },
        { "<leader>hd", group = "Hunk Diff" },
        -- buffer
        { "<leader>bd", group = "Buffer Delete" },
        -- code
        { "<leader>cR", group = "Code Rename" },
        { "<leader>cd", group = "Code Diagnostic" },
        { "<leader>ca", group = "Code Action" },
        { "<leader>rn", group = "Code Rename" },
        { "<leader>ds", group = "Code Document Symbol" },
        -- toggle
        { "<leader>tb", group = "Toggle Blame" },
        -- quickfix
        { "<leader>qo", group = "Quickfix Open" },
        { "<leader>qc", group = "Quickfix Close" },
        -- split
        { "<leader>sv", group = "Split Vertical" },
        { "<leader>sh", group = "Split Horizontal" },
        -- terminal
        { "<leader>tf", group = "Terminal (file dir)" },
        -- LSP (non-leader)
        { "gD", group = "Goto Declaration" },
        { "gd", group = "Goto Definition" },
        { "gr", group = "Goto References" },
        { "gI", group = "Goto Implementation" },
        { "gy", group = "Goto Type" },
        { "gai", group = "Goto Incoming" },
        { "gao", group = "Goto Outgoing" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show { global = false }
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
