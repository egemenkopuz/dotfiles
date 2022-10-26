local M = {}

local options = {
  options = {
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
    disabled_filetypes = { "alpha" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
    },
    lualine_c = {
      {
        "diff",
        symbols = { added = "  ", modified = "  ", removed = "  " },
      },
      "filename",
    },
    lualine_x = {
      {
        "lsp_progress",
        display_components = {
          { "title", "percentage", "message" },
        },
        colors = {
          percentage = "#505A6C",
          title = "#505A6C",
          message = "#505A6C",
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
