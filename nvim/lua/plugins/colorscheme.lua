return {
	-- Default colorscheme
	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("kanso-zen")
		end,
	},
	-- Extras
	"nyoom-engineering/oxocarbon.nvim",
}
