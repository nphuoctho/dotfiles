return {
  -- ─── LSP overrides ──────────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- ─── YAML ─────────────────────────────────────────────────────────
        yamlls = {
          -- Chỉ attach vào yaml thuần, KHÔNG attach docker-compose
          -- (compose đã có docker_compose_language_service handle)
          filetypes = { "yaml" },
          settings = {
            yaml = {
              -- Tắt built-in schemaStore, dùng SchemaStore.nvim (nhiều schema hơn)
              schemaStore = {
                enable = false,
                url = "",
              },
              -- SchemaStore.nvim tự match schema theo tên/path file:
              --   .github/workflows/*.yml  → GitHub Actions
              --   .gitlab-ci.yml           → GitLab CI
              --   *.k8s.yaml               → Kubernetes
              --   .pre-commit-config.yaml  → pre-commit
              schemas = require("schemastore").yaml.schemas(),
              -- Không bắt buộc thứ tự keys (k8s/compose hay break rule này)
              keyOrdering = false,
              validate = true,
              -- Prettier handle formatting, tắt LSP format để tránh conflict
              format = { enable = false },
              -- Hover docs + completion từ schema
              hover = true,
              completion = true,
            },
          },
        },

        -- ─── Docker Compose ───────────────────────────────────────────────
        docker_compose_language_service = {
          -- Match đủ pattern compose phổ biến
          filetypes = { "yaml.docker-compose" },
          root_dir = require("lspconfig.util").root_pattern(
            "docker-compose.yaml",
            "docker-compose.yml",
            "compose.yaml",
            "compose.yml"
          ),
        },

        -- ─── Dockerfile ───────────────────────────────────────────────────
        -- dockerls đã được LazyVim setup mặc định, không cần override
        -- Chỉ thêm nếu muốn custom
        -- dockerls = {},
      },
    },
  },

  -- ─── Filetype detection: bắt thêm các pattern compose không chuẩn ──────
  {
    "LazyVim/LazyVim",
    opts = function()
      vim.filetype.add({
        pattern = {
          -- docker-compose.prod.yml, docker-compose.override.yml, ...
          ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
          -- compose.dev.yml, compose.prod.yml, ...
          ["compose.*%.ya?ml"] = "yaml.docker-compose",
        },
      })
    end,
  },

  -- ─── Mason: đảm bảo tools được cài ──────────────────────────────────────
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "yaml-language-server",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "hadolint", -- linter cho Dockerfile
      })
    end,
  },

  -- ─── Telescope-docker: quản lý containers từ Neovim ─────────────────────
  {
    "lpoto/telescope-docker.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>fD", "<cmd>Telescope docker<cr>", desc = "Docker" },
    },
    config = function()
      require("telescope").load_extension("docker")
    end,
  },
}
