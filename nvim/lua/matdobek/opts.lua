vim.opt.termguicolors = true  -- enable 24-bit RGB colors

vim.opt.softtabstop = 2       -- number of spaces that a <Tab> counts for while performing editing operations
vim.opt.tabstop = 2           -- size (in spaces) of tab
vim.opt.shiftwidth = 2        -- number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true      -- convert tabs to spaces
vim.opt.smartindent = true    -- make indenting smart again
vim.opt.autoindent = true     -- copy indentation from previous line, and apply to next one

vim.opt.hlsearch = true       -- highlight searches
vim.opt.incsearch = true      -- start searching when you type
vim.opt.ignorecase = true     -- ignore case when searching

vim.opt.laststatus = 2        -- last window will have a status line always visible

vim.opt.nu = true             -- show line numbers
vim.opt.relativenumber = true -- display relative number

vim.opt.scrolloff = 10        -- keep X lines above and below cursor when scrolling
vim.opt.colorcolumn = "80"    -- show a vertical line at column 80
vim.opt.textwidth = 80        -- set text width to 80 characters
vim.opt.formatoptions = "ro"  -- :help fo-table
-- vim.opt.wrap = false          -- display long lines as just one line

vim.opt.swapfile = false      -- disable swap files
vim.opt.backup = false        -- disable backup files
vim.opt.undofile = true       -- keep history after exiting file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- where to store undo files
