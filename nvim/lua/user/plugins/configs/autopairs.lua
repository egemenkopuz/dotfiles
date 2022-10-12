local M = {}

local options = {
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" },
}

function M.setup()
  local present, autopairs = pcall(require, "nvim-autopairs")

  if not present then
    return
  end

  autopairs.setup(options)
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
