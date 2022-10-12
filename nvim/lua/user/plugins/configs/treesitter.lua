local M = {}

local options = {
  ensure_installed = {
    "lua",
    "vim",
    "python",
    "html",
    "css",
    "c",
    "cpp",
    "dockerfile",
    "javascript",
    "markdown",
    "yaml",
    "json",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
}

M.lazy_commands = {
  "TSInstall",
  "TSBufEnable",
  "TSBufDisable",
  "TSEnable",
  "TSDisable",
  "TSModuleInfo",
}

function M.setup()
  local present, treesitter = pcall(require, "nvim-treesitter.configs")

  if not present then
    return
  end

  treesitter.setup(options)
end

return M
