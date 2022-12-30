local M = {}

local options = {
  ensure_installed = { "lua-language-server", "hadolint" },
  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = "ﮊ ",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },
  max_concurrent_installers = 10,
}

M.lazy_commands = {
  "Mason",
  "MasonInstall",
  "MasonInstallAll",
  "MasonUninstall",
  "MasonUninstallAll",
  "MasonLog",
}

function M.setup()
  local present, mason = pcall(require, "mason")

  if not present then
    return
  end

  vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
  end, {})

  mason.setup(options)
end

return M
