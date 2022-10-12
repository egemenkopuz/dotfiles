local M = {}

local options = {
  integrations = {
    telescope = false,
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
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.45,
  },
  styles = {
    comments = {},
    conditionals = {},
  },
}

function M.setup()
  local present, catppuccin = pcall(require, "catppuccin")

  if not present then
    return
  end

  catppuccin.setup(options)
  vim.g.catppuccin_flavour = "mocha"
  vim.cmd [[colorscheme catppuccin]]
end

return M
