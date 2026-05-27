return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
        },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = function()
      vim.filetype.add({
        pattern = {
          ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
          ["compose.*%.ya?ml"] = "yaml.docker-compose",
        },
      })
    end,
  },

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
