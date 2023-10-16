local M = {}

local lfs = require('lfs')

M.BASE_NEOVIM_LUA_PATH = os.getenv("HOME").."/.config/nvim/lua"

local is_dir = function(path)
  -- lfs.attributes will error on a filename ending in '/'
    return path:sub(-1) == "/" or lfs.attributes(path, "mode") == "directory"
end
M.get_modules_in_dir = function (path)
  -- Check if supplied path is actually a directory
  if not is_dir(path) then
    print(path.." is not a directory")
    return {}
  end

  local modules = {}
  for file in lfs.dir(path) do
    if file ~= "." and file ~= ".." then
      local extension = string.match(file, "%.lua$")
      if extension then
        local module_name = "keys."..string.gsub(file, "%.lua$", "")
        table.insert(modules, module_name)
      end
    end
  end
  return modules
end

return M
