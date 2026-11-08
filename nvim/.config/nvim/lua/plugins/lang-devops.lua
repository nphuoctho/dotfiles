return {
  -- yamlls (+ SchemaStore Compose schema) already validates compose files; the compose language
  -- service only duplicated its YAML syntax errors.
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { docker_compose_language_service = { enabled = false } } },
  },

  {
    "LazyVim/LazyVim",
    opts = function()
      vim.filetype.add({
        pattern = {
          ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
          -- compose.yaml, compose.prod.yml (not composer.yaml)
          ["compose%.ya?ml"] = "yaml.docker-compose",
          ["compose%..+%.ya?ml"] = "yaml.docker-compose",
        },
      })
    end,
  },

  {
    "krisajenkins/telescope-docker.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>fD", "<cmd>Telescope telescope_docker docker_ps<cr>", desc = "Docker containers" },
    },
    config = function()
      require("telescope").load_extension("telescope_docker")
    end,
  },

  -- nvim-lint runs hadolint on stdin, so it only finds .hadolint.yaml relative to nvim's cwd.
  -- Point it at the config next to the Dockerfile (or any parent) instead.
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        hadolint = {
          args = {
            "-f",
            "json",
            function()
              local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
              local cfg = vim.fs.find({ ".hadolint.yaml", ".hadolint.yml" }, { upward = true, path = dir })[1]
              return cfg and ("--config=" .. cfg) or "--no-color"
            end,
            "-",
          },
        },
      },
    },
  },

  -- shfmt's default (-i <shiftwidth>) rewrites column-aligned dotfile scripts (bspwmrc: 30 lines changed);
  -- -kp keeps column padding.
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        shfmt = { prepend_args = { "-kp" } },
      },
    },
  },

  -- Parsers LazyVim does not install: .sql/.css/commit messages/Makefile/dotfiles had no TS highlight.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(
        opts.ensure_installed,
        { "sql", "css", "gitcommit", "make", "gitignore", "git_config", "ssh_config" }
      )
      vim.treesitter.language.register("bash", "zsh")
    end,
  },

  -- Shell: dotfile scripts (bspwmrc, polybar, ...) had no LSP/lint. bashls runs shellcheck.
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { bashls = {} } },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "bash-language-server", "shellcheck" } },
  },

  -- LazyVim's markdown extra puts markdownlint-cli2 in conform's chain: once lint diagnostics exist it
  -- runs `--fix` on save and rewrites prose (e.g. MD026 strips punctuation from headings; 11/12 real
  -- notes changed). Keep markdownlint as a linter only (nvim-lint).
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      for _, ft in ipairs({ "markdown", "markdown.mdx" }) do
        local chain = opts.formatters_by_ft and opts.formatters_by_ft[ft]
        if chain then
          opts.formatters_by_ft[ft] = vim.tbl_filter(function(f)
            return f ~= "markdownlint-cli2"
          end, chain)
        end
      end
    end,
  },
}
