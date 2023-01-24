return {
    {
        "egemenkopuz/nordic.nvim",
        enabled = true,
        priority = 1000,
        opts = {
            syntax = {
                comments = {
                    italic = false,
                    bold = true,
                },
                operators = {
                    italic = false,
                    bold = false,
                },
                keywords = {
                    italic = false,
                    bold = false,
                },
            },
        },
        config = function(_, opts)
            require("nordic").setup(opts)
            vim.cmd.colorscheme "nordic"
        end,
    },

    {
        "catppuccin/nvim",
        enabled = false,
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            term_colors = true,
            background = {
                light = "latte",
                dark = "mocha",
            },
            no_italic = true, -- Force no italic
            no_bold = true, -- Force no bold
            transparent_background = false,
            compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
            integrations = {
                telescope = false,
                mason = true,
                dap = {
                    enabled = true,
                    enable_ui = true,
                },
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = {},
                        hints = {},
                        warnings = {},
                        information = {},
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
            },
            color_overrides = {
                latte = {
                    base = "#E1EEF5",
                },
                mocha = {
                    base = "#0D0D14",
                },
            },
            highlight_overrides = {
                mocha = function(mocha)
                    return {
                        NvimTreeNormal = { bg = "#0D0D14" },
                        CmpBorder = { fg = mocha.surface2 },
                    }
                end,
            },
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 1.3,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme "catppuccin"
        end,
    },
}
