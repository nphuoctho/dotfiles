-- Không gọi trực tiếp, được require từ LspAttach callback
-- Nhận bufnr để set buffer-local keymaps

local M = {}

function M.on_attach(bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  -- Navigation (các cái này KHÔNG dùng snacks.picker)
  map("K", vim.lsp.buf.hover, "Hover Docs")
  map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  map("<leader>ds", vim.lsp.buf.document_symbol, "Document Symbols")

  -- Diagnostic (buffer-local vì cần context)
  map("<leader>cd", function()
    vim.diagnostic.open_float {
      border = "rounded",
      source = "if_many",
    }
  end, "Show Diagnostic")

  map("]d", function()
    vim.diagnostic.jump { count = 1 }
  end, "Next Error")

  map("[d", function()
    vim.diagnostic.jump { count = -1 }
  end, "Prev Error")
end

return M
