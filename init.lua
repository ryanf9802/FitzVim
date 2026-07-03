local cli_diagnostics_mode = vim.env.NVIM_CLI_DIAGNOSTICS

local function ensure_runtime_dir()
  local run_dir = vim.fn.stdpath("run")
  local run_dir_exists = vim.fn.isdirectory(run_dir) == 1
  local run_dir_writable = vim.fn.filewritable(run_dir) == 2
  if run_dir ~= "" and run_dir_exists and run_dir_writable then
    return
  end

  local uid = vim.uv and vim.uv.getuid and vim.uv.getuid() or vim.fn.getpid()
  local fallback = "/tmp/nvim-" .. uid
  if vim.fn.isdirectory(fallback) == 0 then
    vim.fn.mkdir(fallback, "p", 448)
  end
  vim.fn.setfperm(fallback, "rwx------")

  if vim.fn.isdirectory(fallback) == 1 and vim.fn.filewritable(fallback) == 2 then
    vim.env.XDG_RUNTIME_DIR = fallback
  end
end

ensure_runtime_dir()

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
