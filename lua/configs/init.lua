-- Import required mappings
require("configs/mappings")
require("configs/options")

-- Color Scheme Settings
vim.cmd.colorscheme("tokyonight")
vim.api.nvim_set_hl(0, "Normal", {bg="none"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg="none"})

-- Better File Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
require("nvim-tree").setup({
	view = {
		width = 25,
	},
	filters = {
		dotfiles = false,
	},
})

vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]

