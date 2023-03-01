return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
            },
            lsp = {
                signature = { enabled = false },
                progress = { enabled = false },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
        },
        init = function()
            vim.api.nvim_set_hl(0, "NoiceCmdLinePopup", { bg = "#2E3440" })
            vim.api.nvim_set_hl(0, "NoiceCmdLinePopupBorder", { fg = "#2E3440" })
        end,
        config = true,
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "arkav/lualine-lsp-progress" },
        opts = function()
            local icons = require("user.config").icons
            local utils = require "user.utils"

            return {
                options = {
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "alpha", "packer", "lazy", "terminal" } },
                },
                extensions = { "toggleterm", "neo-tree", "nvim-dap-ui" },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diff",
                            symbols = {
                                added = icons.diff.added,
                                modified = icons.diff.modified,
                                removed = icons.diff.removed,
                            },
                        },
                        {
                            "filename",
                            path = 1,
                            symbols = { readonly = "", unnamed = "" },
                        },
                    },
                    lualine_x = {
                        {
                            "lsp_progress",
                            display_components = { { "title", "percentage", "message" } },
                            colors = {
                                percentage = "#505A6C",
                                title = "#505A6C",
                                message = "#505A6C",
                                use = true,
                            },
                        },
                        {
                            function()
                                local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
                                return "" .. " " .. shiftwidth
                            end,
                            padding = 1,
                        },
                        {
                            "filetype",
                            colored = false,
                            icon_only = false,
                            icon = { align = "right" },
                        },
                        {
                            function()
                                local venv = os.getenv "CONDA_DEFAULT_ENV"
                                    or os.getenv "VIRTUAL_ENV"
                                if venv then
                                    return string.format("(%s)", utils.env_cleanup(venv))
                                end
                                return ""
                            end,
                            cond = function()
                                return vim.bo.filetype == "python"
                            end,
                        },
                    },
                    lualine_y = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.error,
                                warn = icons.diagnostics.warn,
                                info = icons.diagnostics.info,
                                hint = icons.diagnostics.hint,
                            },
                        },
                    },
                    lualine_z = { "location" },
                },
            }
        end,
    },

    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function()
            local config = require "user.config"
            local dashboard = require "alpha.themes.dashboard"
            local fn = vim.fn

            if config.logo then
                dashboard.section.header.val = config.logo
            end

            dashboard.section.buttons.val = {
                dashboard.button("f n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f f", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("f t", " " .. " Find text", ":Telescope live_grep <CR>"),
                dashboard.button("r f", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("s p", " " .. " Select project", ":Telescope projects <CR>"),
                dashboard.button("s s", " " .. " Select session", ":Telescope persisted <CR>"),
                dashboard.button("c c", " " .. " Config", ":e $MYVIMRC | :cd %:p:h <CR>"),
                dashboard.button("c p", " " .. " Plugins", ":Lazy<CR>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }

            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.opts.layout[1].val = fn.max { 2, fn.floor(fn.winheight(0) * 0.1) }

            return dashboard
        end,
        config = function(_, dashboard)
            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                -- stylua: ignore
                callback = function()
                    local date = os.date "%d/%m/%Y "
                    local time = os.date "%H:%M:%S"
                    local v = vim.version()
                    local version = "v" .. v.major .. "." .. v.minor .. "." .. v.patch
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "[" .. date .. time .. "][" .. stats.count .. " plugins " .. ms .. "ms][" .. version .. "]"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },

    {
        "b0o/incline.nvim",
        event = "BufReadPre",
        opts = {
            render = function(props)
                local bufname = vim.api.nvim_buf_get_name(props.buf)
                local filename = " " .. vim.fn.fnamemodify(bufname, ":t") .. " "
                local buffer = { { filename, guibg = "#7E9CD8", guifg = "#191C24" } }

                if vim.api.nvim_buf_get_option(props.buf, "modified") then
                    buffer[1][1] = filename .. "[+]"
                end
                if props.focused == false then
                    buffer[1].guibg = "#191C24"
                    buffer[1].guifg = "#4C566A"
                end
                return buffer
            end,
            window = {
                zindex = 30,
                width = "fit",
                placement = { horizontal = "right", vertical = "top" },
                margin = {
                    horizontal = { left = 1, right = 0 },
                    vertical = { bottom = 0, top = 1 },
                },
                padding = { left = 0, right = 0 },
                padding_char = " ",
                winhighlight = { Normal = "TreesitterContext" },
            },
            hide = {
                cursorline = "focused_win",
                focused_win = false,
                only_win = true,
            },
        },
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        opts = {
            indentLine_enabled = 1,
            char = "┊",
            -- char_list = { "|", "¦", "┆", "┊" },
            filetype_exclude = {
                "alpha",
                "mason",
                "lazy",
                "log",
                "gitcommit",
                "packer",
                "vimwiki",
                "markdown",
                "txt",
                "help",
                "neo-tree",
                "git",
                "TelescopePrompt",
                "undotree",
                "",
            },
            buftype_exclude = { "terminal", "nofile" },
            show_trailing_blankline_indent = false,
            show_first_indent_level = false,
            show_current_context = true,
            show_current_context_start = false,
            space_char = " ",
        },
    },

    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "",
                        padding = 0,
                        text_align = "center",
                        highlight = "Offset",
                    },
                },
                diagnostics = "nvim_lsp",
                show_buffer_close_icons = false,
                show_close_icon = false,
                close_command = "Bdelete! %d",
                color_icons = false,
                always_show_bufferline = false,
            },
        },
        config = function(_, opts)
            opts.options.groups = {
                items = {
                    require("bufferline.groups").builtin.pinned:with { icon = "" },
                },
            }
            require("bufferline").setup(opts)
            require("user.utils").load_keymap "bufferline"
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = {
            user_default_options = { names = false },
            buftypes = { "*", "!alpha", "!mason", "!lazy" },
        },
        config = true,
    },
}
