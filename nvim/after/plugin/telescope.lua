require "telescope".setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader><space>', builtin.buffers, {})
vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
