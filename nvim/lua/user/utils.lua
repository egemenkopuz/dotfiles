local M = {}

local merge_tb = vim.tbl_deep_extend
local general_opts = { noremap = true, silent = true }

local settings = {
    diagnostics = true,
    autoformat = true,
    colorcolumn = true,
}

-- util init
if vim.api.nvim_get_option_value("colorcolumn", {}) == "" then
    settings.colorcolumn = false
else
    settings.colorcolumn = true
end

function M.toggle(var_name)
    settings[var_name] = not settings[var_name]
end

function M.is_enabled(var_name)
    return settings[var_name]
end

function M.notify(message, level, title)
    level = level or vim.log.levels.INFO
    local notify_options = { title = title, timeout = 2000 }
    vim.api.nvim_notify(message, level, notify_options)
end

function M.load_keymap(section_name, add_opts)
    local present, keys = pcall(require, "user.keymaps")
    if not present or keys[section_name] == nil then
        M.notify("Keymaps for " .. section_name .. " not found", vim.log.levels.ERROR)
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

function M.toggle_diagnostics()
    M.toggle "diagnostics"
    if M.is_enabled "diagnostics" then
        vim.diagnostic.show()
        M.notify "Diagnostics enabled"
    else
        vim.diagnostic.hide()
        M.notify "Diagnostics disabled"
    end
end

function M.toggle_autoformat()
    M.toggle "autoformat"
    if M.is_enabled "autoformat" then
        vim.diagnostic.show()
        M.notify "Autoformat enabled"
    else
        vim.diagnostic.hide()
        M.notify "Autoformat disabled"
    end
end

function M.toggle_colorcolumn(col_num)
    col_num = col_num or "79"
    M.toggle "colorcolumn"
    if M.is_enabled "colorcolumn" then
        vim.api.nvim_set_option_value("colorcolumn", col_num, {})
        M.notify "Colorcolumn enabled"
    else
        vim.api.nvim_set_option_value("colorcolumn", "", {})
        M.notify "Colorcolumn disabled"
    end
end

function M.get_python_path(workspace)
    local path = require("lspconfig/util").path
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end
    -- Find and use virtualenv in workspace directory.
    for _, pattern in ipairs { "*", ".*" } do
        local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
        if match ~= "" then
            return path.join(path.dirname(match), "bin", "python")
        end
    end
    -- Fallback to system Python.
    return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

function M.env_cleanup(venv)
    if string.find(venv, "/") then
        local final_venv = venv
        for w in venv:gmatch "([^/]+)" do
            final_venv = w
        end
        venv = final_venv
    end
    return venv
end

function M.path_exists(path)
    local ok = vim.loop.fs_stat(path)
    return ok
end

function M.colorscheme_selection(colorscheme)
    if require("user.config").colorscheme == colorscheme then
        return true
    else
        return false
    end
end

-- return the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
function M.get_root()
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
            local workspace = client.config.workspace_folders
            local paths = workspace
                    and vim.tbl_map(function(ws)
                        return vim.uri_to_fname(ws.uri)
                    end, workspace)
                or client.config.root_dir and { client.config.root_dir }
                or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    return root
end

-- return a function that calls telescope.
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
        if builtin == "files" then
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        require("telescope.builtin")[builtin](opts)
    end
end

function M.pick_window()
    local picked_window_id = require("window-picker").pick_window {
        include_current_win = true,
    } or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
end

function M.swap_window()
    local window = require("window-picker").pick_window { include_current_win = false }
    if window == nil then
        return
    end
    local target_buffer = vim.fn.winbufnr(window)
    vim.api.nvim_win_set_buf(window, 0)
    vim.api.nvim_win_set_buf(0, target_buffer)
end

function M.lsp_on_attach()
    return function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        M.load_keymap("lsp", { buffer = bufnr })
        if client.supports_method "textDocument/signatureHelp" then
            require("lsp_signature").on_attach({}, bufnr)
        end
    end
end

function M.lsp_capabilities()
    local capabilities =
        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    return capabilities
end

function M.formatting()
    return function(client, bufnr)
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    if M.is_enabled "autoformat" then
                        vim.lsp.buf.format { bufnr = bufnr }
                    end
                end,
            })
        end
    end
end

return M
