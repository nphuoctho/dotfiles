-- set language based on vim mode
-- requires macism https://github.com/laishulu/macism
-- recommend installing it by brew
local sysname = vim.uv.os_uname().sysname
local is_linux = sysname == "Linux"

if is_linux then
  local last_layout = "keyboard-us" -- English is default

  local function get_fcitx_layout()
    local f = io.open("fcitx5-remote -n")
    if f ~= nil then
      local result = f:read("*all")
      f:close()
      if result then
        return result:gsub("%s+", "")
      end
    end
    return "keyboard-us"
  end

  local function set_fcitx_layout(layout)
    os.execute("fcitx5-remote -s " .. layout)
  end

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      last_layout = get_fcitx_layout()
      set_fcitx_layout("keyboard-us") -- change to English
    end,
  })

  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      set_fcitx_layout(last_layout)
    end,
  })

  vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
      if vim.fn.mode() == "i" then
        set_fcitx_layout(last_layout)
      else
        set_fcitx_layout("keyboard-us")
      end
    end,
  })
end
