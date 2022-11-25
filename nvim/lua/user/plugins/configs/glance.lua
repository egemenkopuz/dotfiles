local M = {}

M.lazy_commands = {
  "Glance",
}

local options = {}

function M.setup()
  local present, glance = pcall(require, "glance")

  if not present then
    return
  end

  glance.setup(options)
end

return M
