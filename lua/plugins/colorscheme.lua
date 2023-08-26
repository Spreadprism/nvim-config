return {
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = { style = "moon" },
        priority = 1000,
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight",
        },
    }
}