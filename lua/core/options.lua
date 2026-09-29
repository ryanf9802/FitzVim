vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.shortmess:append("I")
vim.opt.textwidth = 0
vim.opt.laststatus = 3
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 2
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.g.mapleader = " "

-- Clipboard: xclip locally; OSC 52 through the terminal when the screen is
-- viewed over SSH, so yanks reach the SSH client's clipboard.
local function over_ssh()
	-- Inside tmux the environment goes stale across attach/detach, so check
	-- the tmux client viewing the pane (same check as the bashrc prompt).
	if vim.env.TMUX then
		local pid = vim.trim(vim.fn.system({ "tmux", "display-message", "-p", "#{client_pid}" }))
		local file = pid ~= "" and io.open("/proc/" .. pid .. "/environ", "rb")
		if file then
			local environ = file:read("*a")
			file:close()
			return environ:find("SSH_CONNECTION=", 1, true) ~= nil
		end
	end
	return vim.env.SSH_CONNECTION ~= nil
end

if vim.fn.has("wsl") == 1 and vim.fn.executable("xclip") == 1 then
	local osc52 = require("vim.ui.clipboard.osc52")
	local selections = { ["+"] = "clipboard", ["*"] = "primary" }

	local function copy(register)
		return function(lines, regtype)
			if over_ssh() then
				return osc52.copy(register)(lines, regtype)
			end
			-- xclip stays running to serve the selection, so detach it.
			local job = vim.fn.jobstart({ "xclip", "-selection", selections[register] }, { detach = true })
			vim.fn.chansend(job, table.concat(lines, "\n") .. (regtype == "V" and "\n" or ""))
			vim.fn.chanclose(job, "stdin")
		end
	end

	local function paste(register)
		return function()
			-- Most terminals refuse OSC 52 reads, so over SSH paste the last
			-- yank from the unnamed register instead of blocking.
			if over_ssh() then
				return { vim.split(vim.fn.getreg('"'), "\n"), vim.fn.getregtype('"') }
			end
			return vim.fn.systemlist({ "xclip", "-selection", selections[register], "-o" })
		end
	end

	vim.g.clipboard = {
		name = "xclip-local-osc52-ssh",
		copy = { ["+"] = copy("+"), ["*"] = copy("*") },
		paste = { ["+"] = paste("+"), ["*"] = paste("*") },
		cache_enabled = false,
	}
	vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
end
