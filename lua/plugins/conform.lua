return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "black" },
			lua = { "stylua" },
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
