local M = {}

local options = {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  direction = "float",
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
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
