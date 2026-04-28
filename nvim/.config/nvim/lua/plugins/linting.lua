---@type LazySpec
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Shared ESLint config files
    local eslint_configs = {
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.json",
      ".eslintrc.yml",
      "eslint.config.js",
      "eslint.config.mjs",
      "eslint.config.cjs",
    }

    local function has_eslint_config(path)
      return vim.fs.find(eslint_configs, { path = path, upward = true })[1] ~= nil
    end

    -- Linters per filetype
    lint.linters_by_ft = {
      javascript = { "eslint_d", "oxlint" },
      typescript = { "eslint_d", "oxlint" },
      javascriptreact = { "eslint_d", "oxlint" },
      typescriptreact = { "eslint_d", "oxlint" },
      python = { "ruff" },
    }

    -- Conditional linters
    lint.linters.eslint_d = vim.tbl_extend("force", lint.linters.eslint_d or {}, {
      condition = function(ctx)
        return has_eslint_config(ctx.dirname)
      end,
    })

    lint.linters.oxlint = vim.tbl_extend("force", lint.linters.oxlint or {}, {
      condition = function(ctx)
        return not has_eslint_config(ctx.dirname)
      end,
    })

    -- Debounce lint (important)
    local uv = vim.loop
    local timer = uv.new_timer()
    local function debounce_lint(ms)
      return function()
        timer:stop()
        timer:start(
          ms,
          0,
          vim.schedule_wrap(function()
            local buf = vim.api.nvim_get_current_buf()

            local max_size = 200 * 1024
            local ok, stats = pcall(uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_size then
              return
            end

            require("lint").try_lint()
          end)
        )
      end
    end

    -- Autocmd (clean + efficient)
    local augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = augroup,
      callback = debounce_lint(100),
    })

    -- Nếu vẫn muốn realtime thì dùng nhẹ thôi
    vim.api.nvim_create_autocmd("TextChanged", {
      group = augroup,
      callback = debounce_lint(300),
    })

    -- Manual trigger
    vim.keymap.set("n", "<leader>cl", function()
      lint.try_lint()
    end, { desc = "Lint file" })
  end,
}
