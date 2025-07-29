local M = {}
local cached_python_path = nil

local function get_venv_python_path(base_path)
  if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    return base_path .. "\\.venv\\Scripts\\python.exe"
  else
    return base_path .. "/.venv/bin/python"
  end
end

function M.find_venv_python()
  if cached_python_path ~= nil then
    return cached_python_path
  end

  local cwd = vim.fn.getcwd()
  local paths_to_check = {}

  table.insert(paths_to_check, get_venv_python_path(cwd))

  local handle = vim.loop.fs_scandir(cwd)
  if handle then
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if type == "directory" then
        local sub_path = get_venv_python_path(cwd .. "/" .. name)
        table.insert(paths_to_check, sub_path)
      end
    end
  end

  for _, path in ipairs(paths_to_check) do
    if vim.fn.filereadable(path) == 1 then
      cached_python_path = path
      return path
    end
  end

  cached_python_path = nil
  return nil
end

return M


