return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    notify.setup({
      render = "compact",
      stages = "fade",
    })
    vim.notify = notify
  end,
}
