local M = {}

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  extensions_list = {
    "persisted",
    "projects",
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
}

function M.setup()
  local present, telescope = pcall(require, "telescope")

  if not present then
    return
  end

  vim.g.theme_switcher_loaded = true

  telescope.setup(options)

  local tc1 = "#2A2B3C"
  local tc2 = "#ABFFF5"
  local tc3 = "#181825"
  local tc4 = "#F38BA8"

  local hl_group = {
    TelescopeMatching = { fg = tc2 },
    TelescopeSelection = { fg = tc2, bg = tc1 },

    TelescopePromptTitle = {
      fg = tc3,
      bg = tc4,
      bold = true,
    },
    TelescopePromptPrefix = { fg = tc2 },
    TelescopePromptCounter = { fg = tc2 },
    TelescopePromptNormal = { bg = tc1 },
    TelescopePromptBorder = { fg = tc1, bg = tc1 },

    TelescopeResultsTitle = {
      fg = tc3,
      bg = tc3,
      bold = true,
    },
    TelescopeResultsNormal = { bg = tc3 },
    TelescopeResultsBorder = { fg = tc3, bg = tc3 },

    TelescopePreviewTitle = {
      fg = tc3,
      bg = tc2,
      bold = true,
    },
    TelescopePreviewNormal = { bg = tc3 },
    TelescopePreviewBorder = { fg = tc3, bg = tc3 },
  }

  for k, v in pairs(hl_group) do
    vim.api.nvim_set_hl(0, k, v)
  end

  pcall(function()
    for _, ext in ipairs(options.extensions_list) do
      telescope.load_extension(ext)
    end
  end)
end

return M
