local M = {}

local options = {
  indentLine_enabled = 1,
  filetype_exclude = {
    "help",
    "terminal",
    "alpha",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "Mason",
    "",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = false,
  show_current_context_start = false,
}

function M.setup()
  local present, blankline = pcall(require, "indent_blankline")

  if not present then
    return
  end

  blankline.setup(options)
end

return M
