local opt = vim.opt
local g = vim.g

g.do_filetype_lua = 1

if vim.fn.has "wsl" == 1 then
  vim.g.clipboard = {
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
  }
else
  opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
end

opt.laststatus = 3 -- global statusline
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.title = true

opt.backup = false -- creates a backup file
opt.cmdheight = 0 -- space in the neovim command line for displaying messages
opt.colorcolumn = "99999" -- indentline

opt.cul = true

opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true

opt.fillchars = { eob = " " }
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- smart case
opt.mouse = "a" -- allow the mouse to be used in neovim

opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false
opt.wrap = false -- display lines as one long line

opt.shortmess:append "sI"
opt.signcolumn = "yes"
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.tabstop = 8
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true -- enable persistent undo
opt.writebackup = false -- if a file is being edited by another program, it is not allowed to be edited

opt.updatetime = 250
g.mapleader = " "

-- disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

-- set shada path
vim.schedule(function()
  vim.opt.shadafile = vim.fn.expand "$HOME"
    .. "/.local/share/nvim/shada/main.shada"
  vim.cmd [[ silent! rsh ]]
end)
