require('set')
require('remap')
require('custom')

vim.pack.add({
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/folke/trouble.nvim',
    { src = 'https://github.com/saghen/blink.cmp', name = 'blink', version = "v1.6.0"},
    --'https://github.com/L3MON4D3/LuaSnip',
    
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-lua/plenary.nvim',

    'https://github.com/lervag/vimtex',
    { src = 'https://github.com/theprimeagen/harpoon', version = 'harpoon2'},
    'https://github.com/mbbill/undotree',
    'https://github.com/tpope/vim-fugitive',
    
    { src = 'https://github.com/lukas-reineke/indent-blankline.nvim', name = 'indent-blankline'},
    'https://github.com/windwp/nvim-autopairs',
    'https://github.com/nvim-lualine/lualine.nvim',
    
    'https://github.com/nvim-tree/nvim-web-devicons',
    {src = 'https://github.com/catppuccin/nvim', name = 'catppuccin'},
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/rebelot/kanagawa.nvim',
    { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' }
    --'https://github.com/',
})


require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 
        'rust_analyzer', 
        'clangd', 
        'marksman', 
        'html', 
        'pyright',
        'jdtls',
        'lua_ls',
        --'ruff_lsp',
        --'pylsp',
    },
})

vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            --lru = {
            --    capacity = 128,
            --},
            --cachePriming = {
            --    enable = false,
            --},
            --check = {
            --    command = "clippy",
            --},
            --checkOnSave = true,
            files = {
                excludeDirs = { "target", ".git", ".cargo", "node_modules" },
            },
            --procMacro = { enable = false },
        },
    },
})

require('nvim-treesitter').setup()
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "rust", "lua", "toml" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

require('blink.cmp').setup({
    signature = { enable = true },
    fuzzy = {implementation = "prefer_rust"},
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
        preset = 'default', 
        ['<Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then return cmp.accept()
                else return cmp.select_and_accept() end
            end,
            'snippet_forward',
            'fallback'
        },
    },

    appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
    menu = {
        auto_show = true,
        draw = {
            treesittor = { "lsp" },
            columns = { { "kind_icon", "label", "label_description", gap = 1}, { "kind" } }
        }
    }
})

require('trouble').setup({
    opts = {}, -- for default options, refer to the configuration section for custom setup.
})

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")

vim.cmd[[colorscheme tokyonight-night]]

require('nvim-autopairs').setup({
    event = "InsertEnter",
    config = true
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.g.vimtex_view_method = "zathura"

require('lualine').setup({
    options = {
        theme = 'rose-pine',
    }
})

require('harpoon').setup()

local harpoon = require('harpoon')
harpoon:setup()
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
