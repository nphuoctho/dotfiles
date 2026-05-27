-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  opts.silent = opts.silent ~= false
  opts.noremap = opts.noremap ~= false

  vim.keymap.set(mode, lhs, rhs, opts)
end

map("i", "jk", "<Esc>", "Exit insert mode")

map("n", "<leader>K", "<CMD>ShowkeysToggle<CR>", "Toggle Show Keys")

map("n", "<leader>cy", function()
  local diags = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
  if #diags == 0 then
    vim.notify("No diagnostic at cursor", vim.log.levels.WARN)
    return
  end
  -- Sắp theo severity (1=ERROR, 2=WARN, 3=INFO, 4=HINT) → lấy nghiêm trọng nhất
  table.sort(diags, function(a, b)
    return a.severity < b.severity
  end)
  local msg = diags[1].message
  vim.fn.setreg("+", msg)
  vim.notify("Copied: " .. msg, vim.log.levels.INFO)
end, "Copy diagnostic message")
