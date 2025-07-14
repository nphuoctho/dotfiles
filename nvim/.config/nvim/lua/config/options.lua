-- LazyNvim Options

local opt = vim.opt
local global = vim.g

-- Set leader keys
global.mapleader = " "
global.maplocalleader = "\\"

-- General
opt.autowrite = true -- Auto save before some actions
opt.confirm = true -- Confirm before exiting with unsaved changes
opt.mouse = "" -- Disable mouse mode
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.undofile = true
opt.undolevels = 10000

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.laststatus = 3
opt.cmdheight = 0
opt.title = true
opt.termguicolors = true
opt.pumblend = 10
opt.pumheight = 10

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Tabs & Indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.smartindent = true
opt.autoindent = true
opt.smarttab = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.inccommand = "nosplit"

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.wildmode = "longest:full,full"
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })

-- Folding
opt.foldlevel = 99
opt.foldenable = true

-- Grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Behavior
opt.backspace = { "start", "eol", "indent" }
opt.scrolloff = 10
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.jumpoptions = "view"
opt.timeoutlen = vim.g.vscode and 1000 or 300
opt.updatetime = 200
opt.virtualedit = "block"
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Formatting
opt.formatoptions = "jcroqlnt"
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions:append("r")

-- Markdown
global.markdown_recommended_style = 0

-- Filetype detection
vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

vim.cmd([[
  au BufNewFile,BufRead *.astro setf astro
  au BufNewFile,BufRead Podfile setf ruby
]])

-- Shell
opt.shell = "fish"

-- Plugins integration (LazyNvim-specific variables)
-- global.lazyvim_picker = "telescope"
-- global.lazyvim_cmp = "blink.cmp"
-- global.lazyvim_prettier_needs_config = true

