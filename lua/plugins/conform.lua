return {
	"stevearc/conform.nvim",
	opts = {
		-- Disabled try and reduce latency
		-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
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
