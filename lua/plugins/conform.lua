return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "black" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			jsonl = { "prettier" },
			markdown = { "prettier" },
			lua = { "stylua" },
			sql = { "sqruff" },
			terraform = { "terraform_fmt" },
		},
	},
}
