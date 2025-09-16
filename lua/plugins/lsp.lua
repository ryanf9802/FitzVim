return {
	{
		"b0o/schemastore.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "b0o/schemastore.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			local python_utils = require("utils.python")
			local venv_python = python_utils.find_venv_python()

			local on_attach = function(_, bufnr)
				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
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

			lspconfig.ts_ls.setup({
				on_attach = on_attach,
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
			})

			lspconfig.jsonls.setup({
				on_attach = on_attach,
				settings = {
					json = {
						schemas = require('schemastore').json.schemas(),
						validate = { enable = true },
					},
				},
			})

			lspconfig.bashls.setup({
				on_attach = on_attach,
			})

			lspconfig.yamlls.setup({
				on_attach = on_attach,
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require('schemastore').yaml.schemas(),
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
				ensure_installed = { "pyright", "lua_ls", "ts_ls", "jsonls", "yamlls", "bashls", "cssls" },
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
					"prettier",
					"shfmt",
					"shellcheck",
				},
				run_on_start = true,
				auto_update = true,
			})
		end,
	},
}
