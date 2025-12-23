-- [[ Basic maps ]]
--  See `:help map()`

local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>l', '<CMD>Lazy<CR>')

-- Diagnostic maps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows

-- Split window
map('n', '<leader>wh', '<CMD>split<CR>', { desc = 'Horizontal split window' })
map('n', '<leader>wv', '<CMD>vsplit<CR>', { desc = 'Vertical split window' })

--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding maps or are not able to send distinct keycodes
-- map('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
-- map('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
-- map('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
-- map('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- Resize window
map('n', '<C-S-h>', '<CMD>vertical resize -5<CR>', { desc = 'Resize left' })
map('n', '<C-S-l>', '<CMD>vertical resize +5<CR>', { desc = 'Resize right' })
map('n', '<C-S-k>', '<CMD>resize -3<CR>', { desc = 'Resize up' })
map('n', '<C-S-j>', '<CMD>resize +3<CR>', { desc = 'Resize down' })

-- Close windows
map('n', '<leader>wc', '<CMD>close<CR>', { desc = 'Close current window' })
map('n', '<leader>wo', '<CMD>only<CR>', { desc = 'Close all other windows' })
map('n', '<leader>wq', '<CMD>wq<CR>', { desc = 'Save & Close window' })

-- Move line
map('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
map('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Keymap buffer
map('n', '<leader>bc', '<CMD>bdelete<CR>', { desc = 'Close current buffer' })

-- Helper keymap
map('n', '<S-k>', vim.lsp.buf.hover, { desc = 'LSP hover' })
map('i', 'jk', '<esc>', { desc = 'Exit insert mode' })
map('n', '<leader>od', function()
  vim.diagnostic.open_float(nil, {
    border = 'rounded',
    focusable = false,
    max_width = 80,
  })
end, { desc = 'Show diagnostic hover' })

-- Quicker save
map('n', '<C-s>', ':w<CR>', { desc = 'Save current file' })
map('i', '<C-s>', '<ESC>:w<CR>', { desc = 'Save current file' })

-- Remove useless functions
map('i', '<esc>', '<nop>')
map('n', '<C-a>', '<nop>')
map('n', '<C-x>', '<nop>')

map('i', '<C-e>', function()
  require('custom.emmet').expand()
end, { desc = 'Emmet expand' })
