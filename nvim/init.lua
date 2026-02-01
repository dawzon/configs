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

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	checker = { enabled = true },
})
