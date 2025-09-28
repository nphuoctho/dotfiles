return {
  "linux-cultist/venv-selector.nvim",
  event = "VeryLazy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "mfussenegger/nvim-dap-python",
  },
  opts = {
    name = "venv",
    auto_refresh = true,
  },
  config = function(_, opts)
    local venv_selector = require("venv-selector")
    venv_selector.setup(opts)

    -- Retrieve cached venv on VimEnter
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Auto select cached virtualenv on open",
      callback = function()
        local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
        if venv ~= "" then
          venv_selector.venv()
        end
      end,
      once = true,
    })
  end,
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Load Cached VirtualEnv" },
  },
}
