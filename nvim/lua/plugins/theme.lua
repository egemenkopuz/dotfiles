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
        opts = {
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            term_colors = true,
            compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
            integrations = {
                leap = true,
                hop = true,
                neotree = true,
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
            highlight_overrides = {
                macchiato = function(x)
                    return { CmpBorder = { fg = x.surface2 } }
                end,
            },
            dim_inactive = { enabled = true, shade = "dark", percentage = 0.15 },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme "catppuccin"
        end,
    },
}
