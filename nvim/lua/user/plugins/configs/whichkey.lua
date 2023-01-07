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
  key_labels = { ["<leader>"] = "SPC" },
}

function M.setup()
  local present, whichkey = pcall(require, "which-key")

  if not present then
    return
  end

  whichkey.setup(options)
  whichkey.register {
    mode = { "n", "v" },
    ["g"] = { name = "+goto" },
    ["]"] = { name = "+next" },
    ["["] = { name = "+prev" },
    ["<leader>b"] = { name = "+buffer" },
    ["<leader>c"] = { name = "+code" },
    ["<leader>f"] = { name = "+file" },
    ["<leader>g"] = { name = "+git" },
    ["<leader>h"] = { name = "+help" },
    ["<leader>o"] = { name = "+open" },
    ["<leader>t"] = { name = "+toggle" },
    ["<leader>x"] = { name = "+diagnostics/quickfix" },
  }
end

return M
