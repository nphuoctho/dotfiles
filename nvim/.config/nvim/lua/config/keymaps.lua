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
  -- sort by severity (1=ERROR..4=HINT), pick the worst one
  table.sort(diags, function(a, b)
    return a.severity < b.severity
  end)
  local msg = diags[1].message
  vim.fn.setreg("+", msg)
  vim.notify("Copied: " .. msg, vim.log.levels.INFO)
end, "Copy diagnostic message")

map("n", "<leader>ud", function()
  local bufnr = 0
  local enabled = vim.diagnostic.is_enabled({ bufnr = bufnr })
  vim.diagnostic.enable(not enabled, { bufnr = bufnr })
  vim.notify("Diagnostic " .. (enabled and "OFF" or "ON") .. " for buffer", vim.log.levels.INFO)
end, "Toggle diagnostic (buffer)")

-- Wrap :source / :so — only allow on .lua / .vim buffers, warn otherwise
vim.api.nvim_create_user_command("SafeSource", function(opts)
  local target = opts.args ~= "" and opts.args or "%"
  if target == "%" then
    local ft = vim.bo.filetype
    local name = vim.fn.expand("%:t")
    if ft == "lua" then
      vim.cmd("luafile %")
      vim.notify("Sourced " .. name, vim.log.levels.INFO, { title = "Source" })
    elseif ft == "vim" then
      vim.cmd("source %")
      vim.notify("Sourced " .. name, vim.log.levels.INFO, { title = "Source" })
    else
      local kind = ft ~= "" and ft or "this"
      vim.notify(
        "Can't source a " .. kind .. " buffer.\nTry :so $MYVIMRC to reload config.",
        vim.log.levels.WARN,
        { title = "Source" }
      )
    end
  else
    vim.cmd("source " .. target)
    vim.notify("Sourced " .. target, vim.log.levels.INFO, { title = "Source" })
  end
end, { nargs = "?", complete = "file", desc = "Safely source file/buffer" })

vim.cmd([[
  cnoreabbrev <expr> so     (getcmdtype() == ':' && getcmdpos() == 3) ? 'SafeSource' : 'so'
  cnoreabbrev <expr> source (getcmdtype() == ':' && getcmdpos() == 7) ? 'SafeSource' : 'source'
]])

map("n", "<leader>cx", function()
  vim.cmd("write")
  local file = vim.fn.expand("%:p")
  local ft = vim.bo.filetype
  local exe
  if ft == "python" then
    local root = vim.fs.find({ "pyproject.toml" }, {
      upward = true,
      path = vim.fn.expand("%:p:h"),
    })[1]
    local has_uv = root ~= nil and vim.fn.executable("uv") == 1
    exe = has_uv and "uv run python" or "python"
  elseif ft == "lua" then
    exe = "lua"
  elseif ft == "sh" or ft == "bash" or ft == "zsh" then
    exe = "bash"
  elseif ft == "go" then
    exe = "go run"
  else
    vim.notify("No runner for filetype: " .. ft, vim.log.levels.WARN)
    return
  end
  vim.cmd("botright 15split | terminal " .. exe .. " " .. vim.fn.shellescape(file))
  vim.cmd("startinsert")
end, "Execute current file")
