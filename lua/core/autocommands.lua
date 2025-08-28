local function open_image_externally()
	local file_path = vim.fn.expand("%:p")
	local cmd_args = {}

	if vim.fn.has("mac") == 1 then
		cmd_args = { "open", file_path }
	elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
		cmd_args = { "cmd", "/c", "start", '""', file_path }
	else
		-- Handle Linux and WSL environments
		if os.getenv("WSL_DISTRO_NAME") then
			local handle = io.popen("wslpath -w '" .. file_path .. "'")
			if not handle then
				vim.notify("Failed to execute wslpath command", vim.log.levels.ERROR)
				return
			end

			local result = handle:read("*a")
			handle:close()

			if not result or result == "" then
				vim.notify("wslpath did not return a path", vim.log.levels.ERROR)
				return
			end

			local windows_path = result:gsub("%s+$", "")

			if vim.fn.executable("powershell.exe") == 1 then
				cmd_args = { "powershell.exe", "-Command", "Start-Process '" .. windows_path .. "'" }
			else
				vim.notify("PowerShell not found in WSL", vim.log.levels.ERROR)
				return
			end
		else
			-- Regular Linux
			local linux_commands = { "xdg-open", "firefox", "google-chrome", "chromium", "eog", "feh", "gpicview" }
			for _, cmd in ipairs(linux_commands) do
				if vim.fn.executable(cmd) == 1 then
					cmd_args = { cmd, file_path }
					break
				end
			end

			if #cmd_args == 0 then
				vim.notify("No suitable image viewer found", vim.log.levels.ERROR)
				return
			end
		end
	end

	vim.fn.jobstart(cmd_args, { detach = true })

	vim.schedule(function()
		if vim.api.nvim_buf_is_valid(vim.fn.bufnr("%")) then
			vim.cmd("bdelete")
		end
	end)
end

vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.bmp", "*.tiff", "*.webp", "*.svg", "*.ico" },
	callback = open_image_externally,
	desc = "Open image files in default system viewer",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.jsonl",
	callback = function()
		vim.bo.filetype = "jsonl"
		vim.cmd("set syntax=json")
	end,
	desc = "Treat .jsonl files as JSON for syntax highlighting without LSP",
})
