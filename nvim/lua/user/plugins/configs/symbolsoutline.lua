local M = {}

local options = {
  symbols = {
    File = { icon = " ", hl = "TSURI" },
    Module = { icon = " ", hl = "TSNamespace" },
    Namespace = { icon = "", hl = "TSNamespace" },
    Package = { icon = "", hl = "TSNamespace" },
    Class = { icon = "ﴯ ", hl = "TSType" },
    Method = { icon = " ", hl = "TSMethod" },
    Property = { icon = "ﰠ ", hl = "TSMethod" },
    Field = { icon = "ﰠ ", hl = "TSField" },
    Constructor = { icon = " ", hl = "TSConstructor" },
    Enum = { icon = " ", hl = "TSType" },
    Interface = { icon = " ", hl = "TSType" },
    Function = { icon = " ", hl = "TSFunction" },
    Variable = { icon = " ", hl = "TSConstant" },
    Constant = { icon = " ", hl = "TSConstant" },
    String = { icon = "𝓐", hl = "TSString" },
    Number = { icon = "#", hl = "TSNumber" },
    Boolean = { icon = "⊨", hl = "TSBoolean" },
    Array = { icon = "", hl = "TSConstant" },
    Object = { icon = " ", hl = "TSType" },
    Key = { icon = " ", hl = "TSType" },
    Null = { icon = "NULL", hl = "TSType" },
    EnumMember = { icon = "", hl = "TSField" },
    Struct = { icon = "פּ ", hl = "TSType" },
    Event = { icon = " ", hl = "TSType" },
    Operator = { icon = "+", hl = "TSOperator" },
    TypeParameter = { icon = "𝙏", hl = "TSParameter" },
  },
}

function M.setup()
  local present, symbolsoutline = pcall(require, "symbols-outline")

  if not present then
    return
  end

  symbolsoutline.setup()
end

return M
