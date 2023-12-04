vim.g.go_doc_keywordprg_enabled = 0

vim.api.nvim_create_autocmd(
    {
        "BufNewFile",
        "BufRead",
    },
    {
        pattern = "*.go",
        callback = function()
          -- vim.keymap.set("n", "gh", ":GoDoc<cr>")
        end
    }
)
