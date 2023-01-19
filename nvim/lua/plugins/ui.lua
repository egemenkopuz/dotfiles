return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-telescope/telescope.nvim",
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
                dashboard.button("c c", " " .. " Config", ":e $MYVIMRC <CR>"),
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
                            guibg = "#181825",
                            guifg = "#CDD6F4",
                        },
                    }
                else
                    return {
                        {
                            fname,
                            guibg = "#181825",
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
}
