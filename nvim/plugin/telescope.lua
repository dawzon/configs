vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
})

local builtin = require("telescope.builtin")

-- Yes, these are from vscode
vim.keymap.set("n", "<C-p>", builtin.find_files)
vim.keymap.set("n", "<C-S-p>", builtin.commands)

vim.keymap.set("n", "<C-S-t>", function()
	builtin.colorscheme({ enable_preview = true })
end)
