local M = {}

function M.expand()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local col = pos[2]

  local abbr = line:sub(1, col):match '[%.%w%-%_]+$'
  if not abbr or abbr == '' then
    return
  end

  vim.lsp.buf_request(0, 'workspace/executeCommand', {
    command = 'emmet.expandAbbreviation',
    arguments = {
      {
        abbreviation = abbr,
        language = vim.bo.ft,
        path = vim.api.nvim_buf_get_name(0),
      },
    },
  }, function(_, result)
    if not result then
      return
    end

    vim.api.nvim_set_current_line(line:sub(1, col - #abbr) .. result[1] .. line:sub(col + 1))
  end)
end

return M
