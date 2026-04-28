-----------------------------------------------------------
-- General Neovim settings and configuration
-- See: https://neovim.io/doc/user/vim_diff.html
-----------------------------------------------------------

local opt = vim.opt -- Set options (lia list/map-like)

-- VISUAL RENDERING
-- ─────────────────────────────────────────────────────────────────────────────────────────────
opt.number = true -- Absolute line numbers in gutter
opt.relativenumber = true -- Relative line numbers (hybrid mode with above)
opt.cursorline = true -- Highlight current line (useful for finding cursor position)
opt.colorcolumn = "100" -- Visual guide at 100 chars (detect long lines early)

opt.scrolloff = 10 -- Keep 10 lines visible above/below cursor (prevents jarring jumps)
opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor
opt.wrap = false -- Don't wrap long lines (easier to scroll horizontally than hunt wrapped text)

opt.termguicolors = true -- 24-bit color support (required for modern themes)
opt.signcolumn = "yes" -- Always show sign column (prevents layout shift from diagnostics)
opt.conceallevel = 0 -- Show all markup (no hidden syntax)
opt.showmode = false -- Don't show mode in command line (lualine shows this)

opt.winborder = "rounded"

-- SPLITS
opt.splitright = true
opt.splitbelow = true

-- COMMAND LINE & COMPLETION
-- ─────────────────────────────────────────────────────────────────────────────────────────────
opt.cmdheight = 1 -- Command line height
opt.completeopt = "menuone,noinsert,noselect" -- Don't auto-select completion items
opt.pumheight = 10 -- Max popup menu items (prevents visual clutter)
opt.pumblend = 10 -- 10% transparent popup (visual polish, minimal performance impact)

opt.wildmenu = true -- Enable command-line completion menu
opt.wildmode = "longest:full,full" -- Complete longest common string, then full options
opt.wildignorecase = true -- Case-insensitive filename completion in command mode
opt.wildoptions = "pum,fuzzy"

-- SEARCH & NAVIGATION
-- ─────────────────────────────────────────────────────────────────────────────────────────────
opt.ignorecase = true -- Default: case-insensitive search
opt.smartcase = true -- Override ignorecase if uppercase in search term
opt.hlsearch = false -- Don't highlight all matches (reduces visual noise)
opt.incsearch = true -- Show matches while typing (immediate feedback)
opt.grepprg = "rg --vimgrep" -- Use ripgrep (faster, better regex support than grep)
opt.grepformat = "%f:%l:%c:%m" -- ripgrep format: file:line:col:message

opt.showmatch = true -- Briefly highlight matching bracket when cursor is on one
opt.matchtime = 2 -- Show match for 0.2 seconds (non-intrusive)

-- TABS & INDENTATION
-- ─────────────────────────────────────────────────────────────────────────────────────────────
opt.tabstop = 2 -- Display tabs as 2 spaces
opt.shiftwidth = 2 -- Indent operations (>>, <<, ==) use 2 spaces
opt.softtabstop = 2 -- Backspace treats 2 spaces as one "tab" unit
opt.expandtab = true -- Use spaces instead of tab characters
opt.smartindent = true -- Automatically indent after {, etc.
opt.autoindent = true -- Maintain indent from previous line

-- FILE OPERATIONS & PERSISTENCE
-- ─────────────────────────────────────────────────────────────────────────────────────────────
opt.backup = false -- No backup files (rely on version control)
opt.writebackup = false -- No backup before overwriting (write directly)
opt.swapfile = false -- No swap files (modern systems have RAM; added complexity with no real gain)
opt.undofile = true -- Persistent undo history across sessions

opt.updatetime = 300 -- Trigger CursorHold after 300ms (used by plugins: diagnostic updates, autosave triggers)
opt.timeoutlen = 500 -- Wait 500ms for mapped key sequences (enough for muscle memory)
opt.ttimeoutlen = 0 -- No wait for terminal key codes (mappings respond immediately)

opt.autoread = true -- Reload file if changed externally (keeps buffer in sync with disk)
opt.autowrite = false -- Don't auto-save (explicit save = fewer accidents)

-- DIFF & MERGE
-- ─────────────────────────────────────────────────────────────────────────────────────────────
opt.diffopt:append("vertical") -- Open diffs in vertical splits (easier to compare side-by-side)
opt.diffopt:append("algorithm:patience") -- Better diff for real code (not just line-by-line)
opt.diffopt:append("linematch:60") -- Smart line matching: align similar lines across diffs

-- WORD & CHARACTER HANDLING
-- ─────────────────────────────────────────────────────────────────────────────────────────────
opt.iskeyword:append("-") -- Treat hyphen as word character (useful for CSS, kebab-case variables)
opt.selection = "inclusive" -- Include character under cursor in visual selection
opt.backspace = "indent,eol,start" -- Backspace deletes indent, end-of-line, and past line start
opt.encoding = "UTF-8" -- UTF-8 encoding everywhere

-- CLIPBOARD & INPUT
-- ─────────────────────────────────────────────────────────────────────────────────────────────
opt.clipboard = "unnamedplus"
opt.modifiable = true -- Allow editing (safeguard against read-only accidents)

-- MISC BEHAVIOR
-- ─────────────────────────────────────────────────────────────────────────────────────────────
opt.errorbells = false -- Disable audio/visual error notifications
opt.autochdir = false -- Don't change directory automatically (prevents surprise in plugins/commands)
opt.path:append("**") -- Recursive path search (enables `gf` to find files in subdirectories)
opt.spelllang = { "en", "vn" } -- Spell checker languages

-- FOLDING (Treesitter-based)
-- ─────────────────────────────────────────────────────────────────────────────────────────────
-- Modern Neovim: use Treesitter for structural awareness instead of indent-based folding
opt.foldmethod = "expr" -- Use expression-based folding (allows semantic folding)
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Treesitter provides syntax-aware fold boundaries
opt.foldlevel = 99 -- Keep folds open by default (user controls when to fold)

-- SPLITS
-- ─────────────────────────────────────────────────────────────────────────────────────────────
opt.splitbelow = true -- New horizontal splits open below current window
opt.splitright = true -- New vertical splits open to the right

-- CURSOR APPEARANCE
-- ─────────────────────────────────────────────────────────────────────────────────────────────
-- Configure cursor shape per mode (visual feedback for mode awareness)
opt.guicursor = {
  "n-v-c:block", -- Normal/Visual/Command: block cursor
  "i-ci-ve:ver25", -- Insert/Command-Insert/Visual-exclusive: block
  "r-cr:hor20", -- Replace/Command-Replace: horizontal line at 20%
  "o:hor50", -- Operator-pending: horizontal line at 50%
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- All modes: blink behavior + highlight groups
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch: faster blink
}

-- UNDO DIRECTORY
-- ─────────────────────────────────────────────────────────────────────────────────────────────
-- Store undo history in a dedicated directory (declutters working directory, persists across sessions)
local undodir = vim.fn.expand("~/.local/share/nvim/undodir")
opt.undodir = undodir
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
