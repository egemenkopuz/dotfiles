return {
    { "folke/lazy.nvim" },

    { "MunifTanjim/nui.nvim" },

    { "nvim-lua/plenary.nvim" },

    {
        "folke/which-key.nvim",
        opts = {
            icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = "  ", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
            },
            hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
            triggers_blacklist = {
                i = { "j", "k" },
                v = { "j", "k" },
            },
            key_labels = { ["<leader>"] = "SPC" },
        },
        config = function(_, opts)
            local wk = require "which-key"
            wk.setup(opts)
            wk.register {
                mode = { "n", "v" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>f"] = { name = "+file" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>h"] = { name = "+help" },
                ["<leader>t"] = { name = "+toggle" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
            }
        end,
    },

    {
        "folke/noice.nvim",
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
        end,
    },
}
