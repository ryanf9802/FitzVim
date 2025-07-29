return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "black" },
			lua = { "stylua" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
      markdown = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			yml = { "prettier" },
		},
		formatters = {
			prettier = {
				prepend_args = { "--jsx-bracket-same-line", "false" },
			},
		},
	},
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format current file",
		},
	},
}
