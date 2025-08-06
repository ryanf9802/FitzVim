-- Ctrl+c copy
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- Obsidian keybindings
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create new Obsidian note" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian notes" })
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick switch Obsidian notes" })
vim.keymap.set("n", "<leader>of", "<cmd>ObsidianFollowLink<CR>", { desc = "Follow Obsidian link" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show Obsidian backlinks" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<CR>", { desc = "Show Obsidian tags" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Open today's daily note" })
vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<CR>", { desc = "Open yesterday's daily note" })
vim.keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<CR>", { desc = "Switch Obsidian workspace" })
vim.keymap.set("v", "<leader>ol", "<cmd>ObsidianLinkNew<CR>", { desc = "Create link from selection" })
vim.keymap.set("n", "<leader>op", "<cmd>ObsidianPasteImg<CR>", { desc = "Paste image from clipboard" })
vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename current note" })
vim.keymap.set("n", "<leader>oi", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian template" })
