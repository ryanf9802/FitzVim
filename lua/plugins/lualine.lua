return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.opt.laststatus = 0

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "lazy", "NvimTree", "dashboard" },
				always_show_tabline = true,
				globalstatus = true,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{ "filename", path = 1 },
					{
						"diagnostics",
						sources = { "nvim_lsp" },
					},
				},
				lualine_x = {
					"encoding",
					{
						"filetype",
						colored = true,
						icon_only = false,
						icon = { align = "center" },
					},
					{
						"fileformat",
						symbols = {
							unix = "", -- default ''
							dos = "", -- default ''
							mac = "", -- default ''
						},
					},
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {},
				lualine_b = {
					{
						"tabs",
						max_length = vim.o.columns / 2,

						mode = 0, -- 0: Shows tab_nr
						-- 1: Shows tab_name
						-- 2: Shows tab_nr + tab_name

						path = 0, -- 0: just shows the filename
						-- 1: shows the relative path and shorten $HOME to ~
						-- 2: shows the full path
						-- 3: shows the full path and shorten $HOME to ~
					},
				},
				lualine_c = { "windows" },
				lualine_x = { {
					"datetime",
					style = "%Y-%m-%d %I:%M %p",
				} },
				lualine_y = {},
				lualine_z = {},
			},
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},

			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
