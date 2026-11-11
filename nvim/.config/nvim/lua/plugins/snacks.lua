return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    -- documentHighlight on CursorHold in insert mode competes with completion on tsserver
    words = { modes = { "n" } },
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

    picker = {
      sources = {
        explorer = {
          actions = {
            -- yazi-like `x`: remember selected paths as "cut" (fallback: current item)
            -- and also yank them so the system clipboard keeps working
            explorer_cut = function(picker)
              if vim.fn.mode():find("^[vV]") then
                picker.list:select()
              end
              local files = {}
              for _, item in ipairs(picker:selected({ fallback = true })) do
                files[#files + 1] = Snacks.picker.util.path(item)
              end
              picker.list:set_selected()
              vim.g.explorer_cut_files = files
              vim.fn.setreg(vim.v.register or "+", table.concat(files, "\n"), "l")
              Snacks.notify.info("Cut " .. #files .. " files")
            end,
            -- `y`: a fresh yank cancels any pending cut so the two never mix
            explorer_yank_reset = function(picker)
              vim.g.explorer_cut_files = nil
              picker:action("explorer_yank")
            end,
            -- `p`: move when files were cut, otherwise stock copy-paste
            explorer_paste_or_move = function(picker)
              local cut = vim.g.explorer_cut_files
              if not cut or #cut == 0 then
                return picker:action("explorer_paste")
              end
              local Tree = require("snacks.explorer.tree")
              local target = picker:dir()
              for _, from in ipairs(cut) do
                local to = target .. "/" .. vim.fn.fnamemodify(from, ":t")
                if vim.uv.fs_stat(to) then
                  Snacks.notify.warn("Skipped, already exists: " .. to)
                elseif vim.uv.fs_stat(from) then
                  Snacks.rename.rename_file({ from = from, to = to })
                  Tree:refresh(vim.fs.dirname(from))
                end
              end
              vim.g.explorer_cut_files = nil
              Tree:refresh(target)
              require("snacks.explorer.actions").update(picker, { target = target })
            end,
            -- `<Esc>`: clear the selection first, close the explorer only when nothing is selected
            explorer_esc = function(picker)
              if #picker:selected() > 0 then
                picker.list:set_selected()
              else
                picker:action("cancel")
              end
            end,
          },
          win = {
            list = {
              keys = {
                ["x"] = { "explorer_cut", mode = { "n", "x" } },
                ["y"] = { "explorer_yank_reset", mode = { "n", "x" } },
                ["p"] = "explorer_paste_or_move",
                ["<Esc>"] = "explorer_esc",
                ["."] = "toggle_hidden",
                ["gr"] = "explorer_focus", -- set cwd to hovered directory (old `.`)
              },
            },
          },
        },
      },
    },

    styles = {
      lazygit = {
        border = "rounded",
      },
    },
  },
}
