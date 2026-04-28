---@type LazySpec
return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = { "onsails/lspkind.nvim" },

  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source with:
  -- build = 'nix run .#build-plugin',

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "none",

      ["<Tab>"] = {
        "select_next",
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        "select_prev",
        "snippet_backward",
        "fallback",
      },

      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },

      ["<CR>"] = { "accept", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },

      ["<C-space>"] = {
        "show",
        "show_documentation",
        "hide_documentation",
      },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
      use_nvim_cmp_as_default = false,
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      keyword = { range = "full" },
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      -- Set to true to automatically insert the first suggestion
      ghost_text = { enabled = true },
      documentation = {
        auto_show = false,
        window = {
          border = "rounded",
        },
      },
      list = {
        selection = { preselect = true, auto_insert = false },
      },

      menu = {
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind" }, { "source_name" } },

          components = {
            kind_icon = {
              text = function(ctx)
                return require("lspkind").symbol_map[ctx.kind] or ""
              end,
            },

            -- Label
            label = {
              width = { fill = true, max = 50 },
              text = function(ctx)
                return ctx.label
              end,
            },

            -- Kind Text
            kind = {
              width = { min = 10 },
              text = function(ctx)
                return ctx.kind
              end,
            },

            -- Source Name
            source_name = {
              width = { min = 6 },
              text = function(ctx)
                local names = {
                  lsp = "LSP",
                  snippets = "SNIP",
                  buffer = "BUF",
                  path = "PATH",
                }

                return names[ctx.source_name] or ctx.source_name
              end,
              highlight = "Comment",
            },
          },
        },
      },
    },

    signature = {
      enabled = true, -- Enable signature help
      window = {
        border = "rounded",
        show_documentation = true,
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lsp = {
          score_offset = 100,
        },
        snippets = {
          score_offset = 80,
        },
        path = {
          score_offset = 60,
        },
        buffer = {
          score_offset = 40,
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      max_typos = 1,
      sorts = {
        "exact", -- match chính xác lên đầu
        "score", -- fuzzy score
        "kind", -- ưu tiên Function, Method
        "sort_text", -- fallback từ LSP
      },
    },
  },
  opts_extend = { "sources.default" },
}
