return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		-- Make indent lines subtle but visible
		vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#343434" })
		require("snacks").setup({
			explorer = { enabled = true },
			bigfile = { enabled = true },
			git = { enabled = true },
			indent = {
				char = "│",
				blank = " ",
				scope = { enabled = false },
				animate = { enabled = false },
			},
			gitbrowse = {
				notify = false,
			},
			quickfile = {
				enabled = true,
			},
			picker = {
				sources = {
					explorer = {
						win = {
							list = {
								keys = {
									["o"] = "confirm",
									["<cr>"] = "explorer_cd",
								},
							},
						},
					},
				},
			},
		})
	end,
	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"<leader>gb",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
		},
	},
}
