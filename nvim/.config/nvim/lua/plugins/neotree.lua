return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- icons support
      "MunifTanjim/nui.nvim",
    },
    lazy = false, -- load immediately
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "File Explorer (cwd)",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.fn.expand("%:p:h") })
        end,
        desc = "File Explorer (file dir)",
      },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("NeotreeStartDir", { clear = true }),
        desc = "Start Neo-tree when opening a directory",
        once = true,
        callback = function()
          local stat = vim.loop.fs_stat(vim.fn.argv(0))
          if stat and stat.type == "directory" then
            require("neo-tree")
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              vim.fn.setreg("+", node:get_id(), "c")
            end,
            desc = "Copy Path",
          },
          ["O"] = {
            function(state)
              vim.fn.jobstart({ "xdg-open", state.tree:get_node().path }, { detach = true })
            end,
            desc = "Open with system app",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
    },
    config = function(_, opts)
      -- Optional: If you're using Snacks.nvim or any file watcher, adjust here
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}

      -- if you don't have Snacks installed, you can safely comment this out
      -- local function on_move(data)
      --   require("snacks.rename").on_rename_file(data.source, data.destination)
      -- end
      -- vim.list_extend(opts.event_handlers, {
      --   { event = events.FILE_MOVED, handler = on_move },
      --   { event = events.FILE_RENAMED, handler = on_move },
      -- })

      require("neo-tree").setup(opts)

      -- auto refresh git status when lazygit closes
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
}
