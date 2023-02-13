return {
    {
        "AlexvZyl/nordic.nvim",
        enabled = false,
        priority = 1000,
        config = function(_, opts)
            require("nordic").setup(opts)
            vim.api.nvim_set_hl(0, "MiniTablineFill", { bg = "#191C24" })
            vim.cmd.colorscheme "nordic"
        end,
    },

    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        priority = 1000,
        config = function(_, opts)
            require("kanagawa").setup(opts)
            vim.cmd.colorscheme "kanagawa"
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
            background = { light = "latte", dark = "mocha" },
            no_italic = true,
            no_bold = true,
            transparent_background = false,
            compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
            integrations = {
                telescope = false,
                mason = true,
                dap = { enabled = true, enable_ui = true },
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
                latte = { base = "#E1EEF5" },
                mocha = { base = "#0D0D14" },
            },
            highlight_overrides = {
                mocha = function(mocha)
                    return {
                        NvimTreeNormal = { bg = "#0D0D14" },
                        CmpBorder = { fg = mocha.surface2 },
                    }
                end,
            },
            dim_inactive = { enabled = true, shade = "dark", percentage = 1.3 },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme "catppuccin"
        end,
    },
}
