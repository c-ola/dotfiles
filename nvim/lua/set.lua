
-- Line Numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Lines
vim.opt.wrap = true

-- whitespace
vim.opt.list = true
vim.opt.listchars = "trail:·"
-- vim.opt.clipboard="unnamedplus"

-- Files
vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "0"
vim.g.mapleader = " "

vim.g.mkdo_auto_start = 1
vim.g.mkdp_auto_close = 1

