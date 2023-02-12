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
                    handler_opts = { border = "single" },
                },
            },
            { "b0o/schemastore.nvim" },
            {
                "RRethy/vim-illuminate",
                opts = {
                    delay = 200,
                    providers = { "lsp", "treesitter", "regex" },
                    filetypes_denylist = { "dirvish", "fugitive", "lazy", "mason", "NvimTree" },
                },
                config = function(_, opts)
                    require("illuminate").configure(opts)
                    vim.api.nvim_create_autocmd("FileType", {
                        callback = function()
                            local buffer = vim.api.nvim_get_current_buf()
                            pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
                            pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
                        end,
                    })
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
                        "--completion-style=detailed",
                        "--completion-parse=always",
                        "--cross-file-rename",
                        "--header-insertion=iwyu",
                        "--suggest-missing-includes",
                        "-j=4", -- number of workers
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
                ["pyright"] = {
                    settings = {
                        pyright = { autoImportCompletion = true },
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = "openFilesOnly",
                                useLibraryCodeForTypes = false,
                                typeCheckingMode = "off",
                            },
                        },
                    },
                },
                ["lua_ls"] = {
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

            vim.diagnostic.config(opts.diagnostics)

            local servers = opts.servers

            require("mason-lspconfig").setup { ensure_installed = vim.tbl_keys(servers) }
            require("mason-lspconfig").setup_handlers {
                function(server)
                    local server_opts = servers[server] or {}
                    local capabilities = utils.lsp_capabilities()

                    server_opts.flags = { debounce_text_changes = 150 }

                    server_opts.on_attach = utils.lsp_on_attach()
                    server_opts.capabilities = capabilities

                    if server == "clangd" then
                        server_opts.capabilities.offsetEncoding = "utf-8"
                    end

                    server_opts.before_init = function(_, config)
                        if server == "pyright" then
                            config.settings.python.pythonPath =
                                utils.get_python_path(config.root_dir)
                        end
                    end

                    if server == "jsonls" then
                        server_opts.settings = {
                            json = {
                                schemas = require("schemastore").json.schemas(),
                                validate = { enable = true },
                            },
                        }
                    elseif server == "yamlls" then
                        server_opts.settings = {
                            yaml = {
                                schemas = require("schemastore").json.schemas {
                                    select = { "docker-compose.yml" },
                                },
                            },
                        }
                    end

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
            local utils = require "user.utils"
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
                    nls.builtins.formatting.prettier,
                    nls.builtins.formatting.stylua,
                    nls.builtins.formatting.rustfmt,
                    nls.builtins.diagnostics.hadolint,
                    nls.builtins.formatting.clang_format,
                },
                on_attach = utils.formatting(),
            }
        end,
    },

    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = { ensure_installed = require("user.config").mason_packages },
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

    {
        "HallerPatrick/py_lsp.nvim",
        event = "BufReadPre",
        dependencies = { "nvim-lspconfig" },
        opts = function()
            local utils = require "user.utils"
            return { capabilities = utils.lsp_capabilities(), on_attach = utils.lsp_on_attach() }
        end,
        config = true,
    },
}
