vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.opt.backup = false -- creates a backup file
vim.opt.cmdheight = 0 -- space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- indentline

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1
vim.opt.ruler = false
vim.opt.wrap = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.signcolumn = "yes"
-- vim.opt.statuscolumn = "%{&nu?(&rnu && v:relnum?v:relnum:v:lnum):''}"
vim.opt.showmode = false
vim.opt.laststatus = 3 -- global statusline
vim.opt.title = true
vim.opt.cursorline = true

-- vim.opt.shortmess:append "sI"
vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case
vim.opt.mouse = "a" -- allow the mouse to be used in neovim

vim.opt.timeoutlen = 400
vim.opt.updatetime = 200
