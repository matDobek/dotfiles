vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzz")
vim.keymap.set("n", "N", "Nzzz")

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>7", "<cmd>!chmod +x %<CR>")

vim.keymap.set("i", "jj", "<esc>")

-- cycle through buffers
vim.keymap.set("n", "K", ":bn<cr>")
vim.keymap.set("n", "J", ":bp<cr>")

-- Set window movement via HJKL
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- quit hlsearch
vim.keymap.set("n", "qq", ":noh<cr>")

-- resize by arrows in normal mode
vim.keymap.set("n", "<left>", ":vertical resize +5<cr>")
vim.keymap.set("n", "<right>", ":vertical resize -5<cr>")

-- reload
vim.keymap.set("n", "<leader>r", ":so<cr>")

-- copy to system clipbord
vim.keymap.set({"n", "v", "s"}, "<leader>y", [["+y]])

-- close buffer
vim.keymap.set("n", "<leader>q", ":bd<cr>")

-- split buffer vertically
vim.keymap.set("n", "<leader>v", ":vsplit<cr>")

-- split buffer horizontally
vim.keymap.set("n", "<leader>x", ":split<cr>")
