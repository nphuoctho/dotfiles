return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current file)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (branch)" },
      { "<leader>gm", "<cmd>DiffviewOpen origin/main...HEAD<cr>", desc = "Diff vs origin/main" },
    },
    opts = function()
      local actions = require("diffview.actions")
      return {
        -- Diff theo style git (1 = unified, 2 = side-by-side, 3 = combined, 4 = histogram)
        diff_binaries = false,
        enhanced_diff_hl = true, -- highlight word-level diff trong dòng
        git_cmd = { "git" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,

        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },

        view = {
          -- Default view: 2 panes side-by-side như VSCode
          default = {
            layout = "diff2_horizontal",
            disable_diagnostics = true, -- tắt LSP diagnostics trong diff view (đỡ noise)
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_horizontal", -- 3-way merge: OURS | BASE | THEIRS
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            disable_diagnostics = true,
            winbar_info = false,
          },
        },

        file_panel = {
          listing_style = "tree", -- "list" | "tree"
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded", -- "never" | "only_folded" | "always"
          },
          win_config = {
            position = "left",
            width = 35,
          },
        },

        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            height = 16,
          },
        },

        commit_log_panel = {
          win_config = {},
        },

        -- ─── Keymaps trong diff view ─────────────────────────────────────────
        keymaps = {
          disable_defaults = false,

          view = {
            { "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
            { "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous file" } },
            { "n", "gf", actions.goto_file_edit, { desc = "Open file (close diff)" } },
            { "n", "<leader>e", actions.focus_files, { desc = "Focus file panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },
            { "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
            { "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
            -- Merge conflict resolution
            { "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Choose OURS" } },
            { "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose THEIRS" } },
            { "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Choose BASE" } },
            { "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Choose ALL" } },
            { "n", "dx", actions.conflict_choose("none"), { desc = "Delete conflict" } },
          },

          file_panel = {
            { "n", "j", actions.next_entry, { desc = "Next entry" } },
            { "n", "k", actions.prev_entry, { desc = "Previous entry" } },
            { "n", "<cr>", actions.select_entry, { desc = "Open diff" } },
            { "n", "o", actions.select_entry, { desc = "Open diff" } },
            { "n", "<2-LeftMouse>", actions.select_entry, { desc = "Open diff" } },
            { "n", "-", actions.toggle_stage_entry, { desc = "Stage/unstage entry" } },
            { "n", "s", actions.toggle_stage_entry, { desc = "Stage/unstage entry" } },
            { "n", "S", actions.stage_all, { desc = "Stage all" } },
            { "n", "U", actions.unstage_all, { desc = "Unstage all" } },
            { "n", "X", actions.restore_entry, { desc = "Discard changes" } },
            { "n", "R", actions.refresh_files, { desc = "Refresh" } },
            { "n", "i", actions.listing_style, { desc = "Toggle list/tree" } },
            { "n", "f", actions.toggle_flatten_dirs, { desc = "Toggle flatten dirs" } },
            { "n", "<tab>", actions.select_next_entry, { desc = "Next entry" } },
            { "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous entry" } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
          },

          file_history_panel = {
            { "n", "g!", actions.options, { desc = "Open options" } },
            { "n", "<cr>", actions.select_entry, { desc = "Open diff" } },
            { "n", "y", actions.copy_hash, { desc = "Copy commit hash" } },
            { "n", "L", actions.open_commit_log, { desc = "Show commit log" } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
          },
        },
      }
    end,
  },
}
