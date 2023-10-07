Mode_keybindings = {
  n = "normal",
  i = "insert",
  v = "visual",
  t = "terminal"
  -- Add more modes if needed
}

Mapping_modules_folder = os.getenv("HOME").."/.config/nvim/lua/keys"

local load_mappings = function (mappings)
  for mode, keybindings in pairs(mappings) do
    if Mode_keybindings[mode] then
      for key, action_config in pairs(keybindings) do
        if #action_config >= 1 then
          local action = action_config[1]
          local description = action_config[2]
          local opts = action_config[3]
          local force_api = action_config[4]
          if opts == nil then
            if description ~= nil then
              opts = { desc = description }
            else
              opts = {}
            end
          else if description ~= nil then
              opts.desc = description
            end
          end
          if force_api == nil or not force_api then
            vim.keymap.set(mode, key, action, opts)
          else
            vim.api.nvim_set_keymap(mode,key,action, opts)
          end
        else
          print(key .. " action is empty")
        end
      end
    end
  end
end

local get_mapping_modules = function ()
  local lfs = require('lfs')
  local modules = {}
  for file in lfs.dir(Mapping_modules_folder) do
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

local modules = get_mapping_modules()

for _, module in pairs(modules) do
  local mappings = require(module)
 load_mappings(mappings)
end

