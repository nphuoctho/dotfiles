local M = {}

local map = vim.keymap.set

-- default opts
M.opts = {
  noremap = true,
  silent = true,
}

-- core function
function M.map(mode, lhs, rhs, desc, extra)
  local options = vim.tbl_extend("force", M.opts, { desc = desc }, extra or {})
  map(mode, lhs, rhs, options)
end

-- mode helpers
function M.n(lhs, rhs, desc, extra)
  M.map("n", lhs, rhs, desc, extra)
end

function M.i(lhs, rhs, desc, extra)
  M.map("i", lhs, rhs, desc, extra)
end

function M.v(lhs, rhs, desc, extra)
  M.map("v", lhs, rhs, desc, extra)
end

function M.x(lhs, rhs, desc, extra)
  M.map("x", lhs, rhs, desc, extra)
end

function M.t(lhs, rhs, desc, extra)
  M.map("t", lhs, rhs, desc, extra)
end

function M.nv(lhs, rhs, desc, extra)
  M.map({ "n", "v" }, lhs, rhs, desc, extra)
end

-- special: no remap (rare case)
function M.remap(mode, lhs, rhs, desc, extra)
  local options = vim.tbl_extend("force", { silent = true }, { desc = desc }, extra or {})
  map(mode, lhs, rhs, options)
end

return M
