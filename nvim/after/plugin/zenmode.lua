require("zen-mode").setup {
  window = {
    width = 90,
    options = {
      number = false,
      relativenumber = false,
    }
  },
  on_open = function(win)
    vim.wo.wrap = true
    vim.wo.linebreak = true
  end,
  on_close = function()
    vim.wo.wrap = false
  end,
}

vim.keymap.set("n", "<leader>zz", function()
  require("zen-mode").toggle()
end)
