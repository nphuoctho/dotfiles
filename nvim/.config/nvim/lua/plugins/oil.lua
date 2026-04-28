---@type LazySpec
return {
  "stevearc/oil.nvim",
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" } },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Hiển thị file detail như ls -la
    columns = { "icon", "permissions", "size", "mtime" },
    -- Các buffer bình thường khi mở thư mục (thay netrw)
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = false, -- toggle bằng <leader>.
      natural_order = true,
      sort = {
        { "type", "asc" }, -- folder lên trên
        { "name", "asc" },
      },
    },
    float = {
      padding = 2,
      max_width = 90,
      max_height = 50,
      border = "rounded",
    },
    keymaps = {
      -- ===== CORE =====
      ["<CR>"] = "actions.select",

      ["l"] = function()
        local entry = require("oil").get_cursor_entry()
        if entry.type == "directory" then
          require("oil").select()
        end
      end,

      ["h"] = { "actions.parent", mode = "n" },

      -- ===== SPLIT =====
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },

      -- ===== PREVIEW =====
      ["<C-p>"] = "actions.preview",

      -- ===== CONTROL =====
      ["q"] = { "actions.close", mode = "n" },
      ["<C-l>"] = "actions.refresh",

      -- ===== NAV =====
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },

      -- ===== CD =====
      ["`"] = { "actions.cd", mode = "n" },
      ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },

      -- ===== VIEW =====
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
  },
}
