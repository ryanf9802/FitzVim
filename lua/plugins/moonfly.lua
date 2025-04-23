return {
  "bluz71/vim-moonfly-colors",
  name = "moonfly",
  priority = 1000,
  enabled = false,
  config = function()
    vim.g.moonflyTransparent = true
    vim.cmd([[colorscheme moonfly]])
  end,
}
