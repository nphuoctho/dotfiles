-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- vtsls: disable formatting (conform/Prettier handles it) + TS-specific keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_vtsls_attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "vtsls" then
      return
    end
    local bufnr = args.buf

    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    local function exec_cmd(cmd)
      client:exec_cmd({
        command = cmd,
        arguments = { vim.uri_from_bufnr(bufnr) },
      })
    end

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("<leader>ci", function() exec_cmd("typescript.sortImports") end, "Sort Imports")
    map("<leader>cu", function() exec_cmd("typescript.removeUnusedImports") end, "Remove Unused Imports")
    map("<leader>co", function() exec_cmd("typescript.organizeImports") end, "Organize Imports")
    map("<leader>cA", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
      })
    end, "Add Missing Imports")
    map("<leader>cT", function() exec_cmd("typescript.restartTsServer") end, "Restart tsserver")
  end,
})
