local M = {}

local options = { keys = "etovxqpdygfblzhckisuran" }

function M.setup()
  local present, hop = pcall(require, "hop")

  if not present then
    return
  end

  hop.setup(options)

  require("user.utils").keys.load_section "hop"
end

return M
