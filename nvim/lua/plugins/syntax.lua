return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "windwp/nvim-autopairs",
        },
        opts = {
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = require("user.config").treesitter_packages,
        },
        config = function(_, opts)
            local treesitter = require "nvim-treesitter.configs"
            treesitter.setup(opts)

            require("treesitter-context").setup()

            local autopairs = require "nvim-autopairs"
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            autopairs.setup { disable_filetype = { "TelescopePrompt", "vim" } }
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

            require("user.utils").load_keymap "treesitter_context"
        end,
    },

    {
        "echasnovski/mini.ai",
        event = "BufReadPre",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        init = function()
            -- no need to load the plugin, since we only need its queries
            require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
        end,
        config = function()
            local ai = require "mini.ai"
            ai.setup {
                custom_textobjects = {
                    b = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter(
                        { a = "@function.outer", i = "@function.inner" },
                        {}
                    ),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
    },

    {
        "echasnovski/mini.surround",
        event = "BufReadPre",
        opts = {
            search_method = "cover_or_next",
            highlight_duration = 2000,
            mappings = {
                add = "ys",
                delete = "ds",
                replace = "cs",
                highlight = "",
                find = "",
                find_left = "",
                update_n_lines = "",
            },
            custom_surroundings = {
                ["("] = { output = { left = "( ", right = " )" } },
                ["["] = { output = { left = "[ ", right = " ]" } },
                ["{"] = { output = { left = "{ ", right = " }" } },
                ["<"] = { output = { left = "<", right = ">" } },
                ["|"] = { output = { left = "|", right = "|" } },
                ["%"] = { output = { left = "<% ", right = " %>" } },
            },
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },

    {
        "echasnovski/mini.comment",
        event = "BufReadPre",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("mini.comment").setup {
                hooks = { pre = require("ts_context_commentstring.internal").update_commentstring },
            }
        end,
    },
}
