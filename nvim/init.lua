vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.inccommand = "split"
vim.opt.spell = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = {
	tab = "> ",
	lead = "·",
	trail = "·",
	nbsp = "+",
}

vim.opt.mouse = "a"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- hjkl window navigation
vim.keymap.set("n", "<c-h>", "<c-w><c-h>", { desc = "move focus to the left window" })
vim.keymap.set("n", "<c-l>", "<c-w><c-l>", { desc = "move focus to the right window" })
vim.keymap.set("n", "<c-j>", "<c-w><c-j>", { desc = "move focus to the lower window" })
vim.keymap.set("n", "<c-k>", "<c-w><c-k>", { desc = "move focus to the upper window" })

-- Split manipulation
vim.keymap.set("n", "<c-left>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<c-right>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<c-up>", ":resize +2<CR>")
vim.keymap.set("n", "<c-down>", ":resize -2<CR>")

vim.keymap.set("n", "<c-s-h>", "<c-w>H")
vim.keymap.set("n", "<c-s-l>", "<c-w>L")
vim.keymap.set("n", "<c-s-k>", "<c-w>K")
vim.keymap.set("n", "<c-s-j>", "<c-w>J")

-- Terminal
vim.keymap.set("t", "<esc>", "<c-\\><c-n>")

-- Enable repeat indents
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })

-- netrw
vim.keymap.set("n", "<c-b>", ":Explore<CR>", { noremap = true })
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 3
vim.g.netrw_cursor = 8
-- vim.g.netrw_liststyle = 3 -- tree
vim.g.netrw_liststyle = 1 -- long
vim.g.netrw_sizestyle = "h"
vim.g.netrw_timefmt = "%-m-%-d-%Y %X"

-- Diagnostics, LSP, code completion
vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	update_in_insert = true,
})
vim.opt.completeopt = { "menu", "menuone", "preview", "noinsert" }
vim.keymap.set("i", "<c-space>", "<c-x><c-o>") -- omnifunc

require("statusline")

vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/RRethy/vim-illuminate",
	"https://github.com/kylechui/nvim-surround",
})
