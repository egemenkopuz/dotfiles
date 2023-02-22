return {
    { "folke/lazy.nvim" },

    { "MunifTanjim/nui.nvim" },

    { "nvim-lua/plenary.nvim" },

    {
        "folke/which-key.nvim",
        opts = {
            icons = { breadcrumb = "»", separator = "  ", group = "+" },
            hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
            triggers_blacklist = { i = { "j", "k" }, v = { "j", "k" } },
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
                ["<leader>q"] = { name = "+quit" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
            }
        end,
    },

    {
        "nvim-tree/nvim-web-devicons",
        opts = { color_icons = false },
        config = true,
    },
}
