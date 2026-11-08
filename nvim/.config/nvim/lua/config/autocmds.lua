-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Turn off spell check when the markdown file contains Vietnamese content (to avoid it turning bright red).
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("user_spell_vi_off", { clear = true }),
  pattern = { "*.md", "*.markdown", "*.mdx", "*.txt" },
  callback = function(args)
    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, 200, false)
    local text = table.concat(lines, "\n")
    if
      text:match(
        "[àáảãạăắằẳẵặâấầẩẫậèéẻẽẹêếềểễệìíỉĩịòóỏõọôốồổỗộơớờởỡợùúủũụưứừửữựỳýỷỹỵđÀÁẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬÈÉẺẼẸÊẾỀỂỄỆÌÍỈĨỊÒÓỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÙÚỦŨỤƯỨỪỬỮỰỲÝỶỸỴĐ]"
      )
    then
      vim.opt_local.spell = false
    end
  end,
})

-- vtsls: delegate formatting to conform and handle its VS Code-only import callback.
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

    -- vtsls resolves `source.organizeImports` with this acknowledgment after
    -- returning the workspace edit. Neovim applies the edit itself.
    client.commands["_typescript.didOrganizeImports"] = function() end

    local function exec_cmd(cmd)
      client:exec_cmd({
        command = cmd,
        arguments = { vim.uri_from_bufnr(bufnr) },
      })
    end

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("<leader>ci", function()
      exec_cmd("typescript.sortImports")
    end, "Sort Imports")
    map("<leader>cu", function()
      exec_cmd("typescript.removeUnusedImports")
    end, "Remove Unused Imports")
    map("<leader>cA", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
      })
    end, "Add Missing Imports")
    map("<leader>cT", function()
      exec_cmd("typescript.restartTsServer")
    end, "Restart tsserver")
  end,
})

-- tsc (TS7 native LSP): no workspace/executeCommand and no refactor code actions, so rebind the
-- vtsls import helpers to LSP source actions (gD lives in lang-web.lua as a server key).
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_tsc_attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "tsc" then
      return
    end
    local bufnr = args.buf

    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end
    local function source_action(kind)
      return function()
        vim.lsp.buf.code_action({ apply = true, context = { only = { kind }, diagnostics = {} } })
      end
    end

    map("<leader>ci", source_action("source.sortImports"), "Sort Imports")
    map("<leader>cu", source_action("source.removeUnusedImports"), "Remove Unused Imports")
    -- source.addMissingImports.ts is not offered by tsc; fixAll adds the missing imports.
    map("<leader>cA", source_action("source.fixAll"), "Add Missing Imports (fixAll)")
  end,
})

-- (vtsls only) nvim 0.12 re-requests textDocument/inlayHint for the whole file after every didChange. tsserver needs
-- ~1s per request, which queues in front of completion and makes the popup empty/slow. Hide hints while
-- typing; they come back (one request) when leaving insert mode.
do
  local group = vim.api.nvim_create_augroup("user_inlay_hints_insert", { clear = true })
  vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    callback = function(args)
      -- Only vtsls needs this; tsc (TS7) does not queue heavy requests in front of completion.
      if
        #vim.lsp.get_clients({ bufnr = args.buf, name = "vtsls" }) > 0
        and vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
      then
        vim.b[args.buf].inlay_hints_suspended = true
        vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
      end
    end,
  })
  vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    callback = function(args)
      if vim.b[args.buf].inlay_hints_suspended then
        vim.b[args.buf].inlay_hints_suspended = nil
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end
    end,
  })
end
