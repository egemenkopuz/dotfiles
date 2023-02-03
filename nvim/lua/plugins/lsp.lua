return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            {
                "ray-x/lsp_signature.nvim",
                opts = {
                    hint_enable = false,
                    hint_prefix = "",
                    fixpos = true,
                    padding = " ",
                    bind = true,
                    handler_opts = {
                        border = "single", -- double, rounded, single, shadow, none, or a table of borders
                    },
                },
            },
            {
                "RRethy/vim-illuminate",
                opts = {
                    delay = 200,
                    providers = { "lsp", "treesitter", "regex" },
                    filetypes_denylist = { "dirvish", "fugitive", "lazy", "mason", "NvimTree" },
                },
                config = function(_, opts)
                    require("illuminate").configure(opts)
                    require("user.utils").load_keymap "illuminate"
                end,
            },
            { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "●" },
                severity_sort = true,
            },
            servers = {
                ["bashls"] = {},
                ["dockerls"] = {},
                ["jsonls"] = {},
                ["yamlls"] = {},
                ["marksman"] = {},
                ["clangd"] = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        -- "--completion-style=bundled",
                        -- "--cross-file-rename",
                        -- "--header-insertion=iwyu",
                    },
                },
                ["rust_analyzer"] = {
                    cargo = { allFeatures = true },
                    checkOnSave = { allFeatures = true, command = "clippy" },
                    procMacro = {
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                },
                ["pyright"] = {},
                ["sumneko_lua"] = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            format = { enable = false },
                            telemetry = { enable = false },
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                library = {
                                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                                },
                                maxPreload = 100000,
                                preloadFileSize = 10000,
                            },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            local lspconfig = require "lspconfig"
            local utils = require "user.utils"

            local function on_attach(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false

                utils.load_keymap("lsp", { buffer = bufnr })

                if client.supports_method "textDocument/signatureHelp" then
                    require("lsp_signature").on_attach({}, bufnr)
                end
            end

            vim.fn.sign_define(
                "DiagnosticSignError",
                { text = "", numhl = "DiagnosticError", linehl = "DiagnosticLineError" }
            )
            vim.fn.sign_define(
                "DiagnosticSignWarn",
                { text = "", numhl = "DiagnosticWarn", linehl = "DiagnosticLineWarn" }
            )
            vim.fn.sign_define(
                "DiagnosticSignInfo",
                { text = "", numhl = "DiagnosticInfo", linehl = "DiagnosticLineInfo" }
            )
            vim.fn.sign_define(
                "DiagnosticSignHint",
                { text = "", numhl = "DiagnosticHint", linehl = "DiagnosticLineHint" }
            )
            vim.diagnostic.config(opts.diagnostics)

            local servers = opts.servers
            local capabilities = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )

            require("mason-lspconfig").setup { ensure_installed = vim.tbl_keys(servers) }
            require("mason-lspconfig").setup_handlers {
                function(server)
                    local server_opts = servers[server] or {}
                    server_opts.on_attach = on_attach
                    server_opts.before_init = function(_, config)
                        if server == "pyright" then
                            config.settings.python.pythonPath =
                                utils.get_python_path(config.root_dir)
                        end
                    end
                    if server == "clangd" then
                        local t_capabilities = vim.deepcopy(capabilities)
                        t_capabilities.offsetEncoding = "utf-8"
                        server_opts.capabilities = t_capabilities
                    else
                        server_opts.capabilities = capabilities
                    end
                    server_opts.flags = { debounce_text_changes = 150 }
                    lspconfig[server].setup(server_opts)
                end,
            }
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        dependencies = { "mason.nvim" },
        config = function()
            local nls = require "null-ls"
            nls.setup {
                sources = {
                    nls.builtins.formatting.isort,
                    nls.builtins.formatting.black,
                    nls.builtins.formatting.trim_newlines,
                    nls.builtins.formatting.trim_whitespace,
                    nls.builtins.diagnostics.flake8,
                    nls.builtins.diagnostics.pydocstyle.with {
                        extra_args = { "--config=$ROOT/setup.cfg" },
                    },
                    -- null_ls.builtins.formatting.prettierd,
                    nls.builtins.formatting.stylua,
                    nls.builtins.formatting.rustfmt,
                    nls.builtins.diagnostics.hadolint,
                    nls.builtins.formatting.clang_format,
                },
                on_attach = function(client, bufnr)
                    local utils = require "user.utils"
                    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
                    if client.supports_method "textDocument/formatting" then
                        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                if utils.is_enabled "autoformat" then
                                    vim.lsp.buf.format { bufnr = bufnr }
                                end
                            end,
                        })
                    end
                end,
            }
        end,
    },

    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ensure_installed = require("user.config").mason_packages,
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require "mason-registry"
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },
}