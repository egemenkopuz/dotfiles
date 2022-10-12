local M = {}

local colors = {
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  gray = "#505A6C",
}

local options = {
  options = {
    theme = "catppuccin",
    component_separators = "",
    section_separators = "",
    globalstatus = true,
    disabled_filetypes = { "alpha" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      {
        "diff",
        symbols = { added = "  ", modified = "  ", removed = "  " },
      },
    },
    lualine_c = { "filename" },
    lualine_x = {
      {
        "lsp_progress",
        display_components = {
          { "title", "percentage", "message" },
        },
        colors = {
          percentage = colors.gray,
          title = colors.gray,
          message = colors.gray,
          use = true,
        },
      },
      {
        "filetype",
        colored = false,
        icon_only = false,
        icon = { align = "right" },
      },
      {
        "diagnostics",
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = "ﯧ",
        },
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}

function M.setup()
  local present, lualine = pcall(require, "lualine")

  if not present then
    return
  end

  lualine.setup(options)
end

return M
