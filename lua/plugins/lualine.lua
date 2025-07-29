return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",

	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename", "diagnostics" },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			tabline = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"tabs",
						mode = 2,
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "datetime" },
			},
		})
	end,
}
