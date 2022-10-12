local M = {}

local options = {}

function M.setup()
  local present, nvim_web_devicons = pcall(require, "nvim-web-devicons")

  if not present then
    return
  end

  local current_icons = nvim_web_devicons.get_icons()
  local new_icons = {}

  for key, icon in pairs(current_icons) do
    icon.color = "#9F9F9F"
    icon.cterm_color = 198
    new_icons[key] = icon
  end

  nvim_web_devicons.set_icon(new_icons)
end

return M
