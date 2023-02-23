vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.fn.has "wsl" == 1 then
    vim.g.clipboard = {
        copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
        paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
    }
else
    vim.opt.clipboard = "unnamedplus"
end

vim.opt.encoding = "UTF-8"
vim.opt.termguicolors = true

vim.opt.backup = false
vim.opt.cmdheight = 0
vim.opt.colorcolumn = ""

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
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.title = true
vim.opt.cursorline = true

vim.opt.showtabline = 1
vim.opt.hidden = true

vim.opt.shortmess:append { W = true, I = true, c = true }
vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.wildmode = "longest:full,full"

vim.opt.confirm = true
vim.opt.undofile = true
vim.opt.undolevels = 10000

vim.opt.timeoutlen = 400
vim.opt.updatetime = 200
