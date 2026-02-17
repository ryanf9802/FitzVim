return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "ruff_format" },
			lua = { "stylua" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
      markdown = { "prettier" },
			scss = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			yml = { "prettier" },
			sh = { "shfmt" },
			bash = { "shfmt" },
		},
		formatters = {
			ruff_format = {
				command = "uv",
				args = {
					"run",
					"ruff",
					"format",
					"--force-exclude",
					"--stdin-filename",
					"$FILENAME",
					"-",
				},
				range_args = function(self, ctx)
					return {
						"run",
						"ruff",
						"format",
						"--force-exclude",
						"--range",
						string.format(
							"%d:%d-%d:%d",
							ctx.range.start[1],
							ctx.range.start[2] + 1,
							ctx.range["end"][1],
							ctx.range["end"][2] + 1
						),
						"--stdin-filename",
						"$FILENAME",
						"-",
					}
				end,
			},
			prettier = {
				prepend_args = { "--jsx-bracket-same-line", "false" },
			},
		},
	},
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format current file",
		},
	},
}
