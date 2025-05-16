vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.shortmess:append("I")
vim.g.mapleader = " "

local python_utils = require("utils.python")

local venv_python = python_utils.find_venv_python()
if venv_python then
	vim.g.python3_host_prog = venv_python
end

-- Clipboard integration via xclip
if vim.fn.has('wsl') == 1 and vim.fn.executable('xclip') == 1 then
  vim.g.clipboard = {
    name = 'xclip-wsl',
    copy = {
      ['+'] = 'xclip -selection clipboard',
      ['*'] = 'xclip -selection primary',
    },
    paste = {
      ['+'] = 'xclip -selection clipboard -o',
      ['*'] = 'xclip -selection primary -o',
    },
    cache_enabled = false,
  }
  -- make unnamed and unnamedplus both use the + register
  vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
end
