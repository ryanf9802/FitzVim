-- Ctrl+c copy --
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- Folding --
vim.keymap.set("n", "za", "za", { desc = "Toggle fold at cursor" })
-- Single
vim.keymap.set("n", "zo", "zo", { desc = "Open fold at cursor" })
vim.keymap.set("n", "zc", "zc", { desc = "Close fold at cursor" })
-- Nested
vim.keymap.set("n", "zO", "zO", { desc = "Open all nested folds at cursor" })
vim.keymap.set("n", "zC", "zC", { desc = "Close all nested folds at cursor" })
-- File
vim.keymap.set("n", "zR", "zR", { desc = "Open all folds in file" })
vim.keymap.set("n", "zM", "zM", { desc = "Close all folds in file" })
