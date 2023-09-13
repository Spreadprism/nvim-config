---@diagnostic disable-next-line: lowercase-global
function notInNeotree()
    local neotree_buffer = "neo-tree filesystem [1]"
    local current_buffer = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
    return neotree_buffer ~= current_buffer and vim.fn.mode() ~= "t"
end

return {
    "branch",
    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 }, cond = notInNeotree },
    { "filename", path = 1, symbols = { modified = "󱇧", readonly = "󰷊", unnamed = "" }, cond = notInNeotree }
}
