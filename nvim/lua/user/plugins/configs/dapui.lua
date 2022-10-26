local M = {}

local options = {}

function M.setup()
  local present, dapui = pcall(require, "dapui")

  if not present then
    return
  end

  dapui.setup(options)
end

return M
