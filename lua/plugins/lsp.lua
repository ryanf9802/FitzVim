return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local python_utils = require("utils.python")
			local venv_python = python_utils.find_venv_python()

			lspconfig.pyright.setup({
				settings = {
					python = {
						pythonPath = venv_python or "python",
            disableVenvSearch = true,
					},
				},
			})

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
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

			lspconfig.terraformls.setup({})

			lspconfig.svelte.setup({
				settings = {
					svelte = {
						["enable-ts-plugin"] = true,
					},
				},
				on_attach = function(client, _)
					if client.name == "svelte" then
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end
				end,
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
				ensure_installed = { "pyright", "lua_ls", "html", "svelte" },
				automatic_installation = {
					exclude = { "tsserver", "ts_ls", "typescript-language-server" },
				},
				handlers = {
					-- Disable default handlers for TypeScript servers
					["tsserver"] = function() end,
					["ts_ls"] = function() end,
					["typescript-language-server"] = function() end,
				},
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
					"prettier",
					"sqruff",
					"stylua",
				},
				run_on_start = true,
				auto_update = true,
			})
		end,
	},
}

