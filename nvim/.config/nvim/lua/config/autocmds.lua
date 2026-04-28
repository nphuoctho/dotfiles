local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Highlight khi yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 150 }
  end,
})

-- Tự resize splits khi resize terminal
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Restore cursor position khi mở lại file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Tắt auto-comment khi bấm Enter sau comment line
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("no_auto_comment"),
  callback = function()
    vim.opt_local.formatoptions:remove { "c", "r", "o" }
  end,
})
