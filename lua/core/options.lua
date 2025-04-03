vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.shortmess:append "I"
vim.g.mapleader = " "

local python_utils = require("utils.python")

local venv_python = python_utils.find_venv_python()
if venv_python then
  vim.g.python3_host_prog = venv_python
end

