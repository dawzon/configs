vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
})

require("mason").setup()

require("mason-tool-installer").setup({
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
})

require("lazydev").setup({
	library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

require("conform").setup({
	format_on_save = {
		timeout_ms = 3000,
		lsp_format = "fallback",
	},
})

require("mason-lspconfig").setup()

local is_nixos = vim.fn.filereadable("/etc/NIXOS") == 1
if is_nixos then
	vim.lsp.enable("nil_ls")
end
