vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.shortmess:append("I")
vim.opt.textwidth = 120
vim.g.mapleader = " "

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
  vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
end
