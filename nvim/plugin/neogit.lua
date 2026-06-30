vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim", -- required
	"https://github.com/sindrets/diffview.nvim", -- optional - Diff integration
	"https://github.com/NeogitOrg/neogit",
})

vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>")
