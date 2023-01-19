vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus"

vim.opt.backup = false -- creates a backup file
vim.opt.cmdheight = 0 -- space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- indentline

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.ruler = false
vim.opt.wrap = false

-- vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.laststatus = 3 -- global statusline
vim.opt.title = true
vim.opt.cul = true

vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.updatetime = 200
