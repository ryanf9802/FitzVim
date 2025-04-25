----------------------------------------------------------------------------
--- Log File Configuration

-- Timer to check for file changes every second
local timer = vim.loop.new_timer()
if timer then
	timer:start(
		0,
		500,
		vim.schedule_wrap(function()
			vim.cmd("checktime")
		end)
	)
end

-- Create an autocommand group for log file tailing
vim.api.nvim_create_augroup("LogFileTail", { clear = true })

-- Track whether the cursor is at the bottom of the file
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	group = "LogFileTail",
	pattern = { "*.log" },
	callback = function()
		local current_line = vim.fn.line(".")
		local last_line = vim.fn.line("$")
		vim.b.auto_scroll = (current_line == last_line)
	end,
})

-- When opening a log file, enable autoread and reduce the updatetime
vim.api.nvim_create_autocmd("BufEnter", {
	group = "LogFileTail",
	pattern = { "*.log" },
	callback = function()
		vim.opt_local.autoread = true
		vim.opt_local.updatetime = 500 -- in milliseconds
	end,
})

-- Periodically check if the file has changed on disk
vim.api.nvim_create_autocmd("CursorHold", {
	group = "LogFileTail",
	pattern = { "*.log" },
	callback = function()
		vim.cmd("checktime")
	end,
})

-- After the file is reloaded, jump to the end only if the user was at the bottom
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	group = "LogFileTail",
	pattern = { "*.log" },
	callback = function()
		if vim.b.auto_scroll then
			vim.cmd("normal! G")
		end
	end,
})

-- Set the filetype for log files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = "LogFileTail",
	pattern = { "*.log" },
	callback = function()
		vim.bo.filetype = "log"
	end,
})
