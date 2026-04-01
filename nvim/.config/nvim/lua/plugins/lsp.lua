return {
  -- LSP Plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      -- ── LspAttach: keymaps set on every buffer when an LSP attaches ──────
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Standard gr* motions (Neovim 0.11 style)
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- ── <leader> LSP keymaps (spec) ───────────────────────────────────
          map('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('<leader>K', vim.lsp.buf.hover, 'Hover Documentation')

          -- ── Helper: check method support across nvim versions ─────────────
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- ── Document highlight on cursor hold ─────────────────────────────
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local hl_group = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- ── Inlay hints toggle ────────────────────────────────────────────
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- ── Diagnostics config ────────────────────────────────────────────────
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(d)
            return d.message
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- ── LSP servers ───────────────────────────────────────────────────────
      local servers = {
        -- Web
        html = {},
        cssls = {},
        jsonls = {},
        tailwindcss = {},
        emmet_language_server = {
          filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact', 'vue', 'svelte' },
        },
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNamehints = 'all',
                includeInlayReturnTypeHints = true,
              },
            },
            javascript = {
              inlayHints = { includeInlayParameterNamehints = 'all' },
            },
          },
        },

        -- ESLint LSP (separate from eslint_d formatter — handles diagnostics)
        eslint = {
          settings = { workingDirectories = { mode = 'auto' } },
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end,
        },

        -- DevOps
        yamlls = {},
        dockerls = {},

        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },

        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = 'standard',
                autoImportCompletions = true,
              },
            },
          },
        },

        -- C / C++
        clangd = {
          cmd = { 'clangd', '--background-index', '--clang-tidy', '--completion-style=detailed' },
          filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        },
      }

      -- ── Mason: auto-install all servers + formatters ───────────────────────
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Lua formatter
        'prettierd', -- JS/TS/JSON/YAML/MD formatter
        'eslint_d', -- ESLint daemon (for conform.nvim)
        -- clangd is installed via the servers table key above
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- ── UI: rounded borders everywhere ────────────────────────────────────
      local windows = require 'lspconfig.ui.windows'
      windows.default_options.border = 'rounded'

      vim.lsp.handlers['textDocument/hover'] = function(_, result, _, conf)
        if not result or not result.contents then
          return
        end
        conf = vim.tbl_extend('force', { border = 'rounded', max_width = 70 }, conf or {})
        vim.lsp.util.open_floating_preview(vim.lsp.util.convert_input_to_markdown_lines(result.contents), 'markdown', conf)
      end

      vim.lsp.handlers['textDocument/signatureHelp'] = function(_, result, _, conf)
        conf = vim.tbl_extend('force', { border = 'rounded' }, conf or {})
        return vim.lsp.util.open_floating_preview(result.contents, 'markdown', conf)
      end
    end,
  },
}
