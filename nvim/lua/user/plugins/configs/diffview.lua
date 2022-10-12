local M = {}

M.lazy_commands = {
  "DiffviewOpen",
  "DiffviewClose",
  "DiffviewToggleFiles",
  "DiffviewFocusFiles",
  "DiffviewRefresh",
  "DiffviewFileHistory",
}

function M.setup()
  local present, diffview = pcall(require, "diffview")

  if not present then
    return
  end

  --   local actions = diffview.actions

  local options = {}

  require("diffview").setup(options)
end

return M
