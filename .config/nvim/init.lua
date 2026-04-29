require('set')
require('remap')
require('custom')

vim.pack.add({
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/neovim/nvim-lspconfig',
	{
		src = 'https://github.com/nvim-treesitter/nvim-treesitter',
		branch = 'main',
		hooks = {
			post_install = function() vim.cmd('TSUpdate') end,
			post_update = function() vim.cmd('TSUpdate') end,
		}
	},
	{
		src = 'https://github.com/folke/trouble.nvim',
	},
	{ src = 'https://github.com/saghen/blink.cmp', name = 'blink'},
	--'https://github.com/L3MON4D3/LuaSnip',

	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-lua/plenary.nvim',

	'https://github.com/lervag/vimtex',
	'https://github.com/mbbill/undotree',
	'https://github.com/tpope/vim-fugitive',

	{ src = 'https://github.com/lukas-reineke/indent-blankline.nvim', name = 'indent-blankline'},
	'https://github.com/windwp/nvim-autopairs',
	'https://github.com/nvim-lualine/lualine.nvim',

	'https://github.com/nvim-tree/nvim-web-devicons',
	{src = 'https://github.com/catppuccin/nvim', name = 'catppuccin'},
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/rebelot/kanagawa.nvim',
	{ src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
	{
		src = 'https://github.com/chomosuke/typst-preview.nvim',
		branch = '1.*',
	}
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

require('nvim-treesitter').setup({
	ensure_installed = { "c", "python", "rust", "lua", "toml", "markdown" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})


require("lspconfig").qmlls.setup {}

require('typst-preview').setup()

require 'typst-preview'.setup {
  debug = false,
  open_cmd = nil,
  port = 0,
  host = '127.0.0.1',
  invert_colors = 'never',
  follow_cursor = true,
  dependencies_bin = {
    tinymist = nil,
    websocat = nil
  },
  extra_args = nil,
  get_root = function(path_of_main_file)
    local root = os.getenv 'TYPST_ROOT'
    if root then
      return root
    end
    -- Look for a project marker so imports from parent dirs stay inside root
    local main_dir = vim.fs.dirname(vim.fn.fnamemodify(path_of_main_file, ':p'))
    local found = vim.fs.find({ 'typst.toml', '.git' }, { path = main_dir, upward = true })
    if #found > 0 then
      return vim.fs.dirname(found[1])
    end

    return main_dir
  end,

  get_main_file = function(path_of_buffer)
    return path_of_buffer
  end,
}

require('blink.cmp').setup({
	--signature = { enable = true },
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
})

require('trouble').setup({
	opts = {},
	cmd = "Trouble",
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
