local M = {}

local options = {
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  term_colors = true,
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
  styles = {
    comments = {},
    conditionals = {},
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {}, -- need to be reset idk how
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    telescope = false,
    mason = true,
    dap = {
      enabled = true,
      enable_ui = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = {},
        hints = {},
        warnings = {},
        information = {},
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
  color_overrides = {
    latte = {
      base = "#E1EEF5",
    },
    mocha = {
      base = "#0D0D14",
    },
  },
  highlight_overrides = {
    latte = function(latte)
      return {
        NvimTreeNormal = { bg = "#D1E5F0" },
      }
    end,
    mocha = function(mocha)
      return {
        NvimTreeNormal = { bg = "#0D0D14" },
        CmpBorder = { fg = mocha.surface2 },
      }
    end,
  },
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 1.3,
  },
}

function M.setup()
  local present, catppuccin = pcall(require, "catppuccin")

  if not present then
    return
  end

  catppuccin.setup(options)
  vim.cmd [[colorscheme catppuccin]]
end

return M
