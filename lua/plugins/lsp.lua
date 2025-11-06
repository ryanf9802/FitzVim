local cli_diagnostics_mode = vim.env.NVIM_CLI_DIAGNOSTICS and vim.env.NVIM_CLI_DIAGNOSTICS ~= "0"

local specs = {
	{
		"b0o/schemastore.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "b0o/schemastore.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			local python_utils = require("utils.python")

			local on_attach = function(client, bufnr)
				if client.name == "ruff" then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end

				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
			end

			lspconfig.ruff.setup({
				on_attach = on_attach,
				init_options = {
					settings = {
						args = {},
					},
				},
			})

			lspconfig.pyright.setup({
				on_attach = on_attach,
				before_init = function(_, config)
					local python_path = python_utils.find_venv_python()
					if python_path then
						config.settings = config.settings or {}
						config.settings.python = config.settings.python or {}
						config.settings.python.pythonPath = python_path
					end
				end,
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
}

}

if not cli_diagnostics_mode then
	table.insert(specs, {
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	})

	table.insert(specs, {
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "ruff", "pyright", "lua_ls", "ts_ls", "jsonls", "yamlls", "bashls", "cssls" },
			})
		end,
	})

	table.insert(specs, {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"ruff",
					"pyright",
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
	})
end

return specs
