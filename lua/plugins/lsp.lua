local cli_diagnostics_mode = vim.env.NVIM_CLI_DIAGNOSTICS and vim.env.NVIM_CLI_DIAGNOSTICS ~= "0"

local specs = {
	{
		"b0o/schemastore.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "b0o/schemastore.nvim" },
		config = function()
			local python_utils = require("utils.python")
			local schemastore = require("schemastore")
			local venv_python = python_utils.find_venv_python()

			local on_attach = function(_, bufnr)
				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
			end

			local server_configs = {
				pyright = {
					settings = {
						python = {
							pythonPath = venv_python or "python",
							disableVenvSearch = true,
						},
					},
				},
				lua_ls = {
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
				},
				ts_ls = {
					filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
				},
				jsonls = {
					settings = {
						json = {
							schemas = schemastore.json.schemas(),
							validate = { enable = true },
						},
					},
				},
				bashls = {},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = schemastore.yaml.schemas(),
						},
					},
				},
			}

			if vim.lsp and vim.lsp.enable then
				vim.lsp.config("*", { on_attach = on_attach })
				for name, cfg in pairs(server_configs) do
					if cfg and next(cfg) ~= nil then
						vim.lsp.config(name, cfg)
					end
				end
				vim.lsp.enable(vim.tbl_keys(server_configs))
			else
				local lspconfig = require("lspconfig")
				for name, cfg in pairs(server_configs) do
					local server = lspconfig[name]
					if server and server.setup then
						server.setup(vim.tbl_deep_extend("force", { on_attach = on_attach }, cfg or {}))
					end
				end
			end

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
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
				ensure_installed = { "pyright", "lua_ls", "ts_ls", "jsonls", "yamlls", "bashls", "cssls" },
			})
		end,
	})

	table.insert(specs, {
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
	})
end

return specs
