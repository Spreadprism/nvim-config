local mode_keybindings = {
    n = "normal",
    i = "insert",
    v = "visual",
    t = "terminal"
    -- Add more modes if needed
  }

--vim.keymap.set('n', '<leader>sh', function() print("hello") end)
--Setting up general bindings
local mappings = require 'keys.general'

for mode, keybindings in pairs(mappings) do
    if mode_keybindings[mode] then
        for key, action_config in pairs(keybindings) do
            if #action_config >= 1 then
                local action = action_config[1]
                local description = action_config[2]
                local opts = action_config[3]
                
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
                vim.api.nvim_set_keymap(mode, key, action, opts)
            else
                print(key .. " action is empty")
            end
        end
    end
end