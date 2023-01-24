return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
            },
            lsp = {
                signature = {
                    enabled = false,
                },
            },
        },
        config = function(_, opts)
            require("noice").setup(opts)
            vim.api.nvim_set_hl(0, "NoiceCmdLinePopup", { bg = "#191C24" })
            vim.api.nvim_set_hl(0, "NoiceCmdLinePopupBorder", { fg = "#191C24" })
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        opts = {
            options = {
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
                disabled_filetypes = {
                    statusline = { "alpha", "packer", "lazy", "terminal" },
                    winbar = { "alpha", "packer", "NvimTree", "nvim-dap-ui" },
                },
            },
            extensions = { "nvim-tree", "toggleterm" },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    { "diff", symbols = { added = "+", modified = "~", removed = "-" } },
                    "filename",
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
                        "filetype",
                        colored = false,
                        icon_only = false,
                        icon = { align = "right" },
                    },
                    {
                        "diagnostics",
                        symbols = {
                            error = " ",
                            warn = " ",
                            info = " ",
                            hint = "ﯧ ",
                        },
                    },
                },
                lualine_y = {},
                lualine_z = { "location" },
            },
        },
        config = function(_, opts)
            require("lualine").setup(opts)
        end,
    },

    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        opts = function()
            local fn = vim.fn
            local dashboard = require "alpha.themes.dashboard"
            local logo = {
                "                                         _.oo.",
                "                 _.u[[/;:,.         .odMMMMMM'",
                "              .o888UU[[[/;:-.  .o@P^    MMM^",
                "             oN88888UU[[[/;::-.        dP^",
                "            dNMMNN888UU[[[/;:--.   .o@P^",
                "           ,MMMMMMN888UU[[/;::-. o@^",
                "           NNMMMNN888UU[[[/~.o@P^",
                "           888888888UU[[[/o@^-..",
                "          oI8888UU[[[/o@P^:--..",
                "       .@^  YUU[[[/o@^;::---..",
                "     oMP     ^/o@P^;:::---..",
                "  .dMMM    .o@^ ^;::---...",
                " dMMMMMMM@^`       `^^^^",
                "YMMMUP^",
                " ^^",
            }

            local function footer()
                local date = os.date "%d/%m/%Y "
                local time = os.date "%H:%M:%S "
                local v = vim.version()
                local version = " v" .. v.major .. "." .. v.minor .. "." .. v.patch
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return date .. time .. stats.count .. ms .. "ms" .. version
            end

            dashboard.section.header.val = logo
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
            dashboard.section.footer.val = footer()

            return dashboard
        end,
        config = function(_, dashboard)
            require("alpha").setup(dashboard.opts)
        end,
    },

    {
        "b0o/incline.nvim",
        event = "BufReadPre",
        opts = {
            render = function(props)
                local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

                if props.focused == true then
                    return {
                        {
                            fname,
                            guibg = "#191C24", --"#181825",
                            guifg = "#CDD6F4",
                        },
                    }
                else
                    return {
                        {
                            fname,
                            guibg = "#191C24", --"#181825",
                            guifg = "#454759",
                        },
                    }
                end
            end,
            window = {
                zindex = 60,
                width = "fit",
                placement = { horizontal = "right", vertical = "top" },
                margin = {
                    horizontal = { left = 1, right = 0 },
                    vertical = { bottom = 0, top = 1 },
                },
                padding = { left = 1, right = 1 },
                padding_char = " ",
                winhighlight = {
                    Normal = "TreesitterContext",
                },
            },
            hide = {
                cursorline = "focused_win",
                focused_win = false,
                only_win = true,
            },
        },
        config = function(_, opts)
            require("incline").setup(opts)
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        opts = {
            indentLine_enabled = 1,
            char = "▏",
            filetype_exclude = {
                "dashboard",
                "mason",
                "log",
                "gitcommit",
                "packer",
                "vimwiki",
                "markdown",
                "txt",
                "help",
                "NvimTree",
                "git",
                "TelescopePrompt",
                "undotree",
                "",
            },
            buftype_exclude = { "terminal", "nofile" },
            show_trailing_blankline_indent = false,
            show_first_indent_level = false,
            show_current_context = false,
            char_list = { "|", "¦", "┆", "┊" },
            space_char = " ",
        },
    },
}
