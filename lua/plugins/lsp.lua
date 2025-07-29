return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local python_utils = require("utils.python")
			local venv_python = python_utils.find_venv_python()

			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
			end

			lspconfig.pyright.setup({
				on_attach = on_attach,
				settings = {
					python = {
						pythonPath = venv_python or "python",
						disableVenvSearch = true,
					},
				},
			})

			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "Snacks" },
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
								"${3rd}/busted/library",
							},
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "lua_ls" },
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black",
					"stylua",
				},
				run_on_start = true,
				auto_update = true,
			})
		end,
	},
}
