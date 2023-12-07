require("neotest").setup({
  adapters = {
    require("neotest-go")({
      experimental = {
        test_table = true,
      },
      args = { "-count=1", "-timeout=60s" }
    })
  },
  status = {
    enabled = true,
    signs = true,
    virtual_text = false
  },
  output_panel = {
    enabled = false,
  },
  output = {
    enabled = true,
    open_on_run = true,
  },
  floating = {
    border = "rounded",
    max_height = 0.6,
    max_width = 0.99,
    options = {
      -- mappings = {
      --   expand = { "<CR>", "<2-LeftMouse>" },
      --   expand_all = "e",
      --   run = "r",
      --   watch = "w"
      -- },
    }
  },
})

vim.keymap.set('n', '<leader>tm', function()
  require("neotest").output.open({ enter = true, short = false })
end)
vim.keymap.set('n', '<leader>tp', function()
  require("neotest").summary.toggle()
end)
vim.keymap.set('n', '<leader>tt', function()
  require('neotest').run.run()
end)
vim.keymap.set('n', '<leader>tf', function()
  require('neotest').run.run(vim.fn.expand('%'))
end)
vim.keymap.set('n', '<leader>ta', function()
  require('neotest').run.run(vim.fn.getcwd())
end)

-- vim.keymap.set('n', '<leader>td', function()
--   require("neotest").run.run({strategy = "dap"})
-- end)

-- require("neodev").setup({
--   library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
-- })
