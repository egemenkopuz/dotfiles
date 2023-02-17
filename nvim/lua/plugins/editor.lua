return {
    {
        "echasnovski/mini.move",
        event = "BufReadPre",
        config = function(_, opts)
            require("mini.move").setup(opts)
        end,
    },

    {
        "smjonas/inc-rename.nvim",
        dependencies = { "folke/noice.nvim" },
        event = "BufReadPre",
        config = function(_, opts)
            require("inc_rename").setup(opts)
            require("user.utils").load_keymap "rename"
        end,
    },

    {
        "dnlhc/glance.nvim",
        event = "BufReadPre",
        config = function(_, opts)
            require("glance").setup(opts)
            require("user.utils").load_keymap "glance"
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "▁" },
                topdelete = { text = "▔" },
                changedelete = { text = "▁" },
            },
            current_line_blame_formatter = "<author> - <author_time:%Y-%m-%d> - <summary>",
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 350,
                ignore_whitespace = false,
            },
            on_attach = function(bufnr)
                require("user.utils").load_keymap("gitsigns", { buffer = bufnr })
            end,
        },
    },

    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewRefresh",
            "DiffviewFileHistory",
        },
        config = function(_, opts)
            require("diffview").setup(opts)
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            direction = "float",
            float_opts = {
                border = "single",
                winblend = 0,
                highlights = { border = "Normal", background = "Normal" },
            },
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)
            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit = Terminal:new {
                cmd = "lazygit",
                hidden = true,
                count = 2,
                on_close = function()
                    vim.cmd [[ "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>" ]]
                end,
            }
            function _LAZYGIT_TOGGLE()
                lazygit:toggle()
            end
            require("user.utils").load_keymap "toggleterm"
        end,
    },

    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        init = function()
            require("user.utils").load_keymap "trouble"
        end,
        opts = { auto_preview = true, mode = "document_diagnostics" },
    },

    {
        "shortcuts/no-neck-pain.nvim",
        cmd = { "NoNeckPain" },
        init = function()
            require("user.utils").load_keymap "zenmode"
        end,
        opts = { toggleMapping = false, widthUpMapping = false, widthDownMapping = false },
    },

    { "ruifm/gitlinker.nvim", event = "BufReadPre", config = true },

    { "tpope/vim-repeat", event = "BufReadPost" },

    { "andymass/vim-matchup", event = "BufReadPost" },

    {
        "moll/vim-bbye",
        event = "BufReadPre",
        config = function(_, _)
            require("user.utils").load_keymap "bufremove"
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
}
