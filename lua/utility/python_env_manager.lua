local M = {}

local function is_directory(path)
    local ok, err, code = os.rename(path, path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it's a directory
            return true
        end
    end
    return ok, err
end

function M.get_venv_dir()
    -- Look locally if venv exists, if not, use default python3
    local current_root = vim.fn.getcwd()
    local venv_path = current_root.."/venv"

    if is_directory(venv_path) then
        -- venv exists
        return venv_path
    else 
        -- use base python3
        return nil
    end
end

function M.get_venv_dir_name()
    local full_dir_path = M.get_venv_dir()
    if full_dir_path ~= nil then
        return vim.fn.fnamemodify(full_dir_path, ":t")
    else
        return "base"
    end
end

function M.get_python_path()
    local full_dir_path = M.get_venv_dir()
    if full_dir_path ~= nil then
        return full_dir_path.."/bin/python"
    else
        return "/usr/bin/python3.11"
    end
end

return M