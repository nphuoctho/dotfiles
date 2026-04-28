local km = require("utils.keymap")

-- INSERT
km.i("jk", "<Esc>", "Exit insert mode")

-- LINE MOVEMENT
km.n("<A-j>", "<cmd>m .+1<cr>==", "Move line down")
km.n("<A-k>", "<cmd>m .-2<cr>==", "Move line up")

km.v("<A-k>", ":m '<-2<cr>gv=gv", "Move selection up")
km.v("<A-j>", ":m '>+1<cr>gv=gv", "Move selection down")

-- SEARCH
km.n("n", "nzzzv", "Next search (centered)")
km.n("N", "Nzzzv", "Prev search (centered)")

km.n("<Esc>", "<cmd>nohlsearch<cr>", "Clear search highlight")

-- SCROLL
km.n("<C-d>", "<C-d>zz", "Scroll down (centered)")
km.n("<C-u>", "<C-u>zz", "Scroll up (centered)")

-- WINDOW NAV
km.n("<C-h>", "<C-w>h", "Go left window")
km.n("<C-j>", "<C-w>j", "Go bottom window")
km.n("<C-k>", "<C-w>k", "Go top window")
km.n("<C-l>", "<C-w>l", "Go right window")

-- SPLIT
km.n("<leader>sv", "<cmd>vsplit<cr>", "Split vertical")
km.n("<leader>sh", "<cmd>split<cr>", "Split horizontal")

-- RESIZE
km.n("<C-Up>", "<cmd>resize +2<cr>", "Increase height")
km.n("<C-Down>", "<cmd>resize -2<cr>", "Decrease height")
km.n("<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease width")
km.n("<C-Right>", "<cmd>vertical resize +2<cr>", "Increase width")

-- BUFFERS
km.n("<S-l>", "<cmd>bnext<cr>", "Next buffer")
km.n("<S-h>", "<cmd>bprev<cr>", "Prev buffer")
km.n("<leader>bd", "<cmd>bdelete<cr>", "Delete buffer")

-- QUICKFIX
km.n("<leader>qo", "<cmd>copen<cr>", "Quickfix open")
km.n("<leader>qc", "<cmd>cclose<cr>", "Quickfix close")
km.n("]q", "<cmd>cnext<cr>", "Next quickfix")
km.n("[q", "<cmd>cprev<cr>", "Prev quickfix")
