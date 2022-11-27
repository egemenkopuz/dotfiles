local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    packer_path,
  }
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

local present, packer = pcall(require, "packer")
if not present then
  return
end

packer.init {
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    working_sym = "ﲊ",
    error_sym = "✗ ",
    done_sym = " ",
    removed_sym = " ",
    moved_sym = "",
    open_fn = function()
      return require("packer.util").float { border = "none" }
    end,
  },
}

packer.startup(function(use)
  local plugins = require "user.plugins"

  for key, val in pairs(plugins) do
    if val and type(val) == "table" then
      plugins[key][1] = key
    end
  end

  for _, v in pairs(plugins) do
    use(v)
  end

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
