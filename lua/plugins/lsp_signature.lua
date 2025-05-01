return {
  "ray-x/lsp_signature.nvim",
  event = "LspAttach",
  config = function()
    require("lsp_signature").setup({
      bind = true,
      floating_window = true,
      hint_enable = true,
      handler_opts = { border = "rounded" },
      floating_window_above_cur_line = true,
    })
  end,
}
