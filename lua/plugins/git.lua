return {
	-- Gitsigns: Inline git decorations
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
		},
		keys = {
			-- Hunk Operations
			{ "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", desc = "[H]unk [S]tage" },
			{ "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", desc = "[H]unk [R]eset" },
			{ "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "[H]unk [U]ndo Stage" },
			{ "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "[H]unk [P]review" },

			-- Hunk Navigation (using functions)
			{
				"]c",
				function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						require("gitsigns").next_hunk()
					end)
					return "<Ignore>"
				end,
				expr = true,
				desc = "Next Hunk",
			},
			{
				"[c",
				function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						require("gitsigns").prev_hunk()
					end)
					return "<Ignore>"
				end,
				expr = true,
				desc = "Previous Hunk",
			},
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},

	-- Diffview: Dedicated diff viewer
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "[G]it [V]iew Diffs" },
			{ "<leader>gV", "<cmd>DiffviewOpen --cached<cr>", desc = "[G]it [V]iew Staged" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "[G]it [H]istory for current file" },
			{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "[G]it [C]lose Diff View" },
		},
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		opts = {},
		config = function(_, opts)
			require("diffview").setup(opts)
		end,
	},
}
