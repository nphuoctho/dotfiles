-- Readable venv-selector entries: drop "/bin/python", abbreviate $HOME, and show
-- "<project>/<venv>" for project-local venvs. Display only; the real path is untouched.
local project_sources = { workspace = true, cwd = true, file = true }

local function format_venv(line, source)
  if type(line) ~= "string" then
    return line
  end
  local dir = line:match("^(.+)/bin/python[%d.]*$") or line:match("^(.+)\\Scripts\\python%.exe$")
  if not dir then
    return line
  end
  if project_sources[source] then
    local project, venv = dir:match("([^/]+)/([^/]+)$")
    if project then
      return project .. "/" .. venv
    end
  end
  local home = vim.env.HOME
  if home and home ~= "" and dir:sub(1, #home + 1) == home .. "/" then
    dir = "~" .. dir:sub(#home + 1)
  end
  return dir
end

return {
  {
    "linux-cultist/venv-selector.nvim",
    opts = { options = { on_telescope_result_callback = format_venv } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyrefly = {
          -- pyrefly logs INFO to stderr and nvim stores every stderr line in lsp.log at ERROR level
          cmd_env = { PYREFLY_LOG = "error" },
          -- The LSP default preset is "basic", which drops bad-assignment / missing-attribute /
          -- missing-argument errors; "default" matches basedpyright's "basic" in head-to-head tests.
          init_options = { pyrefly = { typeCheckingMode = "default" } },
        },
        basedpyright = {
          settings = {
            basedpyright = {
              typeCheckingMode = "basic",
              analysis = {
                inlayHints = {
                  variableTypes = true,
                  callArgumentNames = true,
                  functionReturnTypes = true,
                  genericTypes = false,
                },
              },
            },
          },
        },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if vim.g.lazyvim_python_lsp == "pyrefly" then
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "pyrefly")
      end
    end,
  },
}
