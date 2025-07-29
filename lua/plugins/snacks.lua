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
				enabled = true,
				backend = "fzf-lua",
				opts = {
					fzf_opts = {
						["--layout"] = "reverse-list",
					},
				},
				sources = {
					files = {
						hidden = true,
						no_ignore = false,
					},
					explorer = {
						hidden = true,
						no_ignore = false,
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
			"<leader>ff",
			function()
				if vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true") then
					Snacks.picker.git_files()
				else
					Snacks.picker.files()
				end
			end,
			desc = "Find Files (Git-aware)",
		},
		{
			"<leader>fg",
			function()
				if vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true") then
					Snacks.picker.grep({ git = true })
				else
					Snacks.picker.grep()
				end
			end,
			desc = "Live Grep (Git-aware)",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find Buffers",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent Files",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Tags",
		},
		{
			"<leader>fF",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files (All files including gitignored)",
		},
		{
			"<leader>fG",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live Grep (All files including gitignored)",
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
