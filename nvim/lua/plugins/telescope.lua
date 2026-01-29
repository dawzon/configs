return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")

		-- Yes, these are from vscode
		vim.keymap.set("n", "<C-p>", builtin.find_files)
		vim.keymap.set("n", "<C-S-p>", builtin.commands)

		vim.keymap.set("n", "<C-S-t>", function()
			builtin.colorscheme({ enable_preview = true })
		end)
	end,
}
