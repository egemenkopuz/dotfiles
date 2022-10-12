local M = {}

local options = {
  mappings = {
    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    basic = false,
    ---Extra mapping; `gco`, `gcO`, `gcA`
    extra = false,
    ---Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
    extended = false,
  },
}

function M.setup()
  local present, comment = pcall(require, "comment")

  if not present then
    return
  end

  comment.setup(options)
end

return M
