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
                ["<leader>d"] = { name = "+debug" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>f"] = { name = "+find" },
                ["<leader>s"] = { name = "+search" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>h"] = { name = "+help" },
                ["<leader>t"] = { name = "+toggle" },
                ["<leader>w"] = { name = "+workspace" },
                ["<leader>u"] = { name = "+ui" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
            }
        end,
    },

    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            local nvim_web_devicons = require "nvim-web-devicons"
            local current_icons = nvim_web_devicons.get_icons()
            local new_icons = {}

            for key, icon in pairs(current_icons) do
                icon.color = "#9F9F9F"
                icon.cterm_color = 198
                new_icons[key] = icon
            end

            nvim_web_devicons.set_icon(new_icons)
        end,
    },

    {
        "moll/vim-bbye",
        event = "BufReadPre",
        config = function(_, _)
            require("user.utils").load_keymap "bufremove"
        end,
    },
}
