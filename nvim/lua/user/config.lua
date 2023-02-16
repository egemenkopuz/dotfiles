local M = { icons = {} }

-- stylua: ignore start
vim.fn.sign_define( "DiagnosticSignError", { text = "", numhl = "DiagnosticError", linehl = "DiagnosticLineError" })
vim.fn.sign_define( "DiagnosticSignWarn", { text = "", numhl = "DiagnosticWarn", linehl = "DiagnosticLineWarn" })
vim.fn.sign_define( "DiagnosticSignInfo", { text = "", numhl = "DiagnosticInfo", linehl = "DiagnosticLineInfo" })
vim.fn.sign_define( "DiagnosticSignHint", { text = "", numhl = "DiagnosticHint", linehl = "DiagnosticLineHint" })
vim.fn.sign_define( "DapBreakpoint", { text = "", numhl = "DapBreakpoint", linehl = "DapBreakpoint" })
vim.fn.sign_define( "DagLogPoint", { text = "", numhl = "DapLogPoint", linehl = "DapLogPoint" })
vim.fn.sign_define( "DapStopped", { text = "", numhl = "DapStopped", linehl = "DapStopped" })
-- stylua: ignore end
vim.api.nvim_set_hl(0, "DapBreakpoint", { bg = "#454545" })
vim.api.nvim_set_hl(0, "DapLogPoint", { bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "white", bg = "#B14238" })

-- auto install treesitter packages
M.treesitter_packages = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "toml",
    "vim",
    "yaml",
}

-- auto install mason packages
M.mason_packages = {
    -- lsp
    "bash-language-server",
    "lua-language-server",
    "pyright",
    "clangd",
    -- formatter
    "stylua",
    "black",
    "isort",
    "clang-format",
    -- dap
    "debugpy",
}

M.nulls_packages = {
    formatting = {
        "isort",
        "black",
        "trim_newlines",
        "trim_whitespace",
        "prettier",
        "stylua",
        "clang_format",
        "rustfmt",
    },
    diagnostics = {
        "flake8",
        "mypy",
        { "pydocstyle", extra_args = { "--config=$ROOT/setup.cfg" } },
        "hadolint",
    },
}

M.disabled_plugins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "syntax",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

-- Dashboard logo
M.logo = nil

-- Diagnostics icons
M.icons.diagnostics = {
    error = " ",
    warn = " ",
    info = " ",
    hint = "ﯧ ",
}

M.icons.diff = {
    added = "+",
    modified = "~",
    removed = "-",
}

-- Syntax icons
M.icons.kinds = {
    Namespace = "",
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = "ﰠ ",
    Variable = " ",
    Class = "ﴯ ",
    Interface = " ",
    Module = " ",
    Property = "ﰠ ",
    Unit = "塞 ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = "פּ ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
    Table = "",
    Object = " ",
    Tag = "",
    Array = "[]",
    Boolean = " ",
    Number = " ",
    Null = "ﳠ",
    String = " ",
    Calendar = "",
    Watch = " ",
    Package = "",
}

return M
