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
	-- Look if conda env exists if not,
	-- Look locally if venv exists, if not, use default python3
	local current_root = vim.fn.getcwd()

	local conda_env_name = vim.fn.fnamemodify(current_root, ":t")

	local conda_env_path = os.getenv("HOME") .. "/miniconda3/envs/" .. conda_env_name
	local conda_env_path_env = conda_env_path .. "_env"
	local venv_path = current_root .. "/venv"

	if is_directory(conda_env_path) then
		-- we have a conda env called {root_dir}
		return conda_env_path
	elseif is_directory(conda_env_path_env) then
		-- we have a conda env called {root_dir}_env
		return conda_env_path_env
	elseif is_directory(venv_path) then
		-- we have a venv directory
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
		return full_dir_path .. "/bin/python"
	else
		local path = os.getenv("HOME") .. "/miniconda3/bin/python"
		-- print(path) -- for debugging purposes
		return path
	end
end

function M.get_pytest_path()
	local full_dir_path = M.get_venv_dir()
	if full_dir_path ~= nil then
		return full_dir_path .. "/bin/pytest"
	else
		local path = os.getenv("HOME") .. "/miniconda3/bin/pytest"
		-- print(path) -- for debugging purposes
		return path
	end
end

return M
