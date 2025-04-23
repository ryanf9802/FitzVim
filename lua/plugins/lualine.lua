return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.opt.laststatus = 3

    require("lualine").setup {
      options = {
        icons_enabled     = true,
        theme             = "auto",
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        disabled_filetypes   = { "lazy", "NvimTree", "dashboard" },
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
        lualine_c = { "filename" , {
          "diagnostics",
          sources = { "nvim_lsp" },
        }},
        lualine_x = { "encoding", "fileformat", "filetype" },
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
    }
  end,
}
