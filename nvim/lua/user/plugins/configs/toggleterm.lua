local M = {}

local options = {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  direction = "float",
  float_opts = {
    border = "single",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

function M.setup()
  local present, toggleterm = pcall(require, "toggleterm")

  if not present then
    return
  end

  toggleterm.setup(options)
end

return M
