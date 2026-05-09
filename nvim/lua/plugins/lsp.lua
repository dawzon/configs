return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"astro",
				"bashls",
				"clangd",
				"cssls",
				"docker_language_server",
				"fish_lsp",
				"gopls",
				"html",
				"jdtls",
				"kotlin_lsp",
				"lua_ls",
				"rust_analyzer",
				"systemd_lsp",
				"ts_ls",
				"vimls",
				"nixfmt",
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("lazydev").setup({})
			require("mason-lspconfig").setup()

			local is_nixos = vim.fn.filereadable("/etc/NIXOS") == 1
			if is_nixos then
				vim.lsp.enable("nil_ls")
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = {
				timeout_ms = 3000,
				lsp_format = "fallback",
			},
		},
	},
}
