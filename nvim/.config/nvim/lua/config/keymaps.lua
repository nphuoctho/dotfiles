-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  opts.silent = opts.silent ~= false
  opts.noremap = opts.noremap ~= false

  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>uk", "<CMD>ShowkeysToggle<CR>", "Toggle Show Keys") -- <leader>K is LazyVim Keywordprg

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
    vim.cmd({ cmd = "source", args = { target } })
    vim.notify("Sourced " .. target, vim.log.levels.INFO, { title = "Source" })
  end
end, { nargs = "?", complete = "file", desc = "Safely source file/buffer" })

vim.cmd([[
  cnoreabbrev <expr> so     (getcmdtype() == ':' && getcmdpos() == 3) ? 'SafeSource' : 'so'
  cnoreabbrev <expr> source (getcmdtype() == ':' && getcmdpos() == 7) ? 'SafeSource' : 'source'
]])

-- Run the current file in a terminal split. Uses jobstart({term = true}) with an argv list: the old
-- `:terminal <cmd>` form let Vim expand `%`/`#` in file names (e.g. `1.lab#01_4.cpp`).
map("n", "<leader>cx", function()
  vim.cmd("write")
  local file = vim.api.nvim_buf_get_name(0)
  local dir = vim.fs.dirname(file)
  local ft = vim.bo.filetype
  local argv
  if ft == "python" then
    local has_project = vim.fs.find({ "pyproject.toml" }, { upward = true, path = dir })[1] ~= nil
    argv = (has_project and vim.fn.executable("uv") == 1) and { "uv", "run", "python", file } or { "python", file }
  elseif ft == "lua" then
    argv = { "lua", file }
  elseif ft == "sh" or ft == "bash" then
    argv = { "bash", file }
  elseif ft == "zsh" then
    argv = { "zsh", file }
  elseif ft == "go" then
    argv = { "go", "run", file }
  elseif ft == "c" or ft == "cpp" then
    -- -O2 keeps timings comparable to contest judges; sanitizers catch out-of-bounds in DSA code.
    local cc = ft == "cpp" and "g++ -std=c++23" or "gcc -std=gnu2x"
    local out = vim.fn.tempname()
    argv = {
      "sh",
      "-c",
      cc
        .. ' -g -O2 -Wall -Wextra -fsanitize=address,undefined "$1" -o "$2"'
        .. (ft == "c" and " -lm" or "")
        .. ' && "$2"',
      "sh",
      file,
      out,
    }
  else
    vim.notify("No runner for filetype: " .. ft, vim.log.levels.WARN)
    return
  end
  vim.cmd("botright 15split | enew")
  vim.fn.jobstart(argv, { term = true, cwd = dir })
  vim.cmd("startinsert")
end, "Execute current file")
