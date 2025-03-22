local catppuccin = {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function ()
        --vim.cmd([[colorscheme catppuccin]])
    end,
}

return {
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd("colorscheme tokyonight-night")
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            --vim.cmd("colorscheme rose-pine")
        end
    },
    catppuccin,
}

