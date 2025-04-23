return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- optional: enable global statusline if you like the single‐line‐across‐all‐windows look
    vim.opt.laststatus = 3

    require("lualine").setup {
      options = {
        icons_enabled     = true,
        theme             = "auto",
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        disabled_filetypes   = { "lazy", "NvimTree", "dashboard" },
      },
      sections = {
        lualine_a = { "mode" },
        -- ← here is your bottom-left: branch name + diff stats
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
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
