vim.api.nvim_create_user_command("aidisable", function()
  require("supermaven-nvim.api").stop()
  print("AI Completion disabled for current buffer")
end, {})

vim.api.nvim_create_user_command("aienable", function()
  require("supermaven-nvim.api").start()
  print("AI Completion enabled for current buffer")
end, {})

