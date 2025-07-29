local plugins = {}

local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", false, true)

for _, file in ipairs(plugin_files) do
	local plugin_name = vim.fn.fnamemodify(file, ":t:r")
	if plugin_name ~= "init" then
		local plugin_config = require("plugins." .. plugin_name)
		if type(plugin_config) == "table" then
			table.insert(plugins, plugin_config)
		end
	end
end

return plugins
