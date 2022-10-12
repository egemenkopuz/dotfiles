vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH
  .. (is_windows and ";" or ":")
  .. vim.fn.stdpath "data"
  .. "/mason/bin"

require "user.options"

vim.defer_fn(function()
  require("user.utils").keys.load_section "general"
end, 0)

require "user.packer"
