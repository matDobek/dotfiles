require("nvim-tree").setup({
  sort_by = "case_sensitive",
  disable_netrw = true,
  view = {
    adaptive_size = true,
    centralize_selection = false,
    width = 40,
    side = "left",
  },
  git = {
    enable = false,
  },
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
})

vim.keymap.set("n", "<c-p>", function()
	if require'nvim-tree.view'.is_visible() then
		vim.cmd(":NvimTreeToggle")
  elseif string.len(vim.fn.expand("%")) > 0 then
		vim.cmd(":NvimTreeFindFile")
	else
    -- if there is no file open, then open nvim-tree
		vim.cmd(":NvimTreeToggle")
	end
end)
