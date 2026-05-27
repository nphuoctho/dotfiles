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
