local M = {}

local options = {
  render = function(props)
    local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

    if props.focused == true then
      return {
        {
          fname,
          guibg = "#181825",
          guifg = "#CDD6F4",
        },
      }
    else
      return {
        {
          fname,
          guibg = "#181825",
          guifg = "#454759",
        },
      }
    end
  end,
  window = {
    zindex = 60,
    width = "fit",
    placement = { horizontal = "right", vertical = "top" },
    margin = {
      horizontal = { left = 1, right = 0 },
      vertical = { bottom = 0, top = 1 },
    },
    padding = { left = 1, right = 1 },
    padding_char = " ",
    winhighlight = {
      Normal = "TreesitterContext",
    },
  },
  hide = {
    cursorline = "focused_win",
    focused_win = false,
    only_win = true,
  },
}

function M.setup()
  local present, incline = pcall(require, "incline")

  if not present then
    return
  end

  incline.setup(options)
end

return M
