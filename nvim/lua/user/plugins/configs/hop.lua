local M = {}

local options = { keys = "etovxqpdygfblzhckisuran" }

function M.setup()
  local present, hop = pcall(require, "hop")

  if not present then
    return
  end

  hop.setup(options)

  vim.api.nvim_set_hl(0, "HopNextKey", { bold=true, fg = "#ff007c", bg = "None" })
  vim.api.nvim_set_hl(0, "HopNextKey1", { bold=true, fg = "#00dfff", bg = "None" })
  vim.api.nvim_set_hl(0, "HopNextKey2", { fg = "#2b8db3", bg = "None" })

  require("user.utils").keys.load_section "hop"
end

return M
