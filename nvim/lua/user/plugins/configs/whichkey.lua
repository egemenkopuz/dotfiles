local M = {}

local options = {
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "  ", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

function M.setup()
  local present, whichkey = pcall(require, "which-key")

  if not present then
    return
  end

  whichkey.setup(options)
end

return M
