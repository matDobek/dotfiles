require("matdobek/packages")
require("matdobek/opts")
require("matdobek/mappings")

-- enable filetype detection
vim.cmd('filetype plugin indent on')

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local PreSaveGroup = augroup('PreSaveGroup', {})

-- remove trailing whitespace on save
autocmd({"BufWritePre"}, {
    group = PreSaveGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- remove empty lines on save
autocmd({"BufWritePre"}, {
    group = PreSaveGroup,
    pattern = "*",
    command = [[%s/\n\+\%$//e]],
})
