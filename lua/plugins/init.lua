-- Load local configuration override
local ok, local_cfg = pcall(require, "local_config")
local disabled = (ok and local_cfg.disable_plugins) or {}

-- Plugin module names
local modules = {
  "plugins.conform",
  "plugins.moonfly",
  "plugins.nvim-tree",
  "plugins.telescope",
  "plugins.treesitter",
  "plugins.lsp",
  "plugins.typescript-tools",
  "plugins.cmp",
  "plugins.autopairs",
  "plugins.autotag",
  "plugins.surround",
  "plugins.supermaven",
  "plugins.luasnip",
  "plugins.golf",
}

-- is this module in the disabled list?
local function is_disabled(name)
  for _, v in ipairs(disabled) do
    if v == name then return true end
  end
  return false
end

-- require only the ones _not_ disabled
local loaded = {}
for _, name in ipairs(modules) do
  if not is_disabled(name) then
    table.insert(loaded, require(name))
  end
end

return loaded
