-- This is used to ensure the theme background is not overwritten by the lualine bar background
local groups = {
  "StatusLine", "StatusLineNC",
  "LualineNormal", "LualineInsert", "LualineVisual",
  "LualineReplace", "LualineCommand", "LualineInactive",
}

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for _, g in ipairs(groups) do
      vim.api.nvim_set_hl(0, g, { bg = "NONE", ctermbg = "NONE" })
    end
  end,
})

vim.api.nvim_exec_autocmds("ColorScheme", { pattern = "*" })
