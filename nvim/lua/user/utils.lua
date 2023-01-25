local M = {}

local merge_tb = vim.tbl_deep_extend
local general_opts = { noremap = true, silent = true }

M.notify = function(message, level, title)
    local notify_options = {
        title = title,
        timeout = 2000,
    }
    vim.api.nvim_notify(message, level, notify_options)
end

function M.load_keymap(section_name, add_opts)
    local present, keys = pcall(require, "user.keymaps")
    if not present or keys[section_name] == nil then
        return
    end
    for mode, mapping in pairs(keys[section_name]) do
        for lhs, rhs in pairs(mapping) do
            local opts = merge_tb("force", general_opts, rhs.opts or {})
            rhs.opts = nil
            if rhs[2] ~= nil then
                opts = merge_tb("force", opts, { desc = rhs[2] })
            end
            opts = merge_tb("force", opts, add_opts or {})
            vim.keymap.set(mode, lhs, rhs[1], opts)
        end
    end
end

DIAGNOSTICS_ACTIVE = true
M.toggle_diagnostics = function()
    DIAGNOSTICS_ACTIVE = not DIAGNOSTICS_ACTIVE
    if DIAGNOSTICS_ACTIVE then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

-- detect python venv
-- https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-851247107
-- local util = require "lspconfig/util"
-- local path = util.path
-- function M.get_python_path(workspace)
--     -- Use activated virtualenv.
--     if vim.env.VIRTUAL_ENV then
--         return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
--     end
--     -- Find and use virtualenv in workspace directory.
--     for _, pattern in ipairs { "*", ".*" } do
--         local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
--         if match ~= "" then
--             return path.join(path.dirname(match), "bin", "python")
--         end
--     end
--     -- Fallback to system Python.
--     return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
-- end

AUTOFORMAT_ACTIVE = true
M.toggle_autoformat = function()
    AUTOFORMAT_ACTIVE = not AUTOFORMAT_ACTIVE
end

M.path_exists = function(path)
    local ok = vim.loop.fs_stat(path)
    return ok
end

M.telescope_find_files = function()
    local path = vim.loop.cwd() .. "/.git"
    if M.path_exists(path) then
        return "Telescope git_files"
    else
        return "Telescope find_files"
    end
end

-- toggle colorcolumn
M.toggle_colorcolumn = function()
    local value = vim.api.nvim_get_option_value("colorcolumn", {})
    if value == "" then
        M.notify("Enable colorcolumn", 1, "functions.lua")
        vim.api.nvim_set_option_value("colorcolumn", "79", {})
    else
        M.notify("Disable colorcolumn", 1, "functions.lua")
        vim.api.nvim_set_option_value("colorcolumn", "", {})
    end
end

return M
