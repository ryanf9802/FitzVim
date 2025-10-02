local cli_diagnostics_mode = vim.env.NVIM_CLI_DIAGNOSTICS

if cli_diagnostics_mode and cli_diagnostics_mode ~= "0" then
  pcall(function()
    if vim.loader and vim.loader.enable then
      vim.loader.enable(false)
    elseif vim.loader and vim.loader.disable then
      vim.loader.disable()
    end
  end)
  vim.opt.swapfile = false
  vim.opt.shadafile = "NONE"
end

require("core.options")
require("core.keymaps")
require("core.autocommands")
require("lazy_setup")
