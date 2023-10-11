local buffer_blacklist = {"neo-tree filesystem [1]"}

---@diagnostic disable-next-line: lowercase-global
function DisplayFilename()
  -- INFO: Check if we are currently in a terminal
  if vim.fn.mode() == "t" then
    return false
  end

  local current_buffer = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")

  -- INFO: Don't need to check all of our blacklisted filename, its empty
  if current_buffer == "" then
    return false
  end

  local display = true
  for _, str in ipairs(buffer_blacklist) do
    if current_buffer == str then
      -- INFO: Current buffer is in the blacklist, no need to search futher
      display = false
      break
    end
  end

  return display
end

return {
    "branch",
    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 }, cond = DisplayFilename },
    { "filename", path = 0, symbols = { modified = "󱇧", readonly = "󰷊", unnamed = "" }, cond = DisplayFilename }
}
