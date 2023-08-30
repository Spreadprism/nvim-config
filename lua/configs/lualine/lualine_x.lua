local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
}

-- LSP clients attached to buffer
local clients_lsp = function ()
    local bufnr = vim.api.nvim_get_current_buf()
  
    local clients = vim.lsp.buf_get_clients(bufnr)
    if next(clients) == nil then
      return "  "..'No lsp'
    end
  
    local c = {}
    for _, client in pairs(clients) do
        local name = client.name
        table.insert(c, client.name)
    end
    local venv = os.execute("")
    return "  " .. table.concat(c, '|')
  end

return {
    {
        clients_lsp
    },
    {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
            color_error = { fg = colors.red },
            color_warn = { fg = colors.yellow },
            color_info = { fg = colors.cyan },
        },
        sections = { 'error', 'warn', 'info' },
        always_visible = true
    }
}