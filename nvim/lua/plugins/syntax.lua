return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "windwp/nvim-ts-autotag",
            "nvim-treesitter/nvim-treesitter-context",
            "windwp/nvim-autopairs",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        opts = function()
            local MAX_FILE_LINES = 3000
            local MAX_FILE_SIZE = 1048576 -- 1MB

            return {
                sync_install = false,
                autotag = { enable = true },
                indent = { enable = true },
                context_commentstring = { enable = true, enable_autocmd = false },
                ensure_installed = require("user.config").treesitter_packages,
                highlight = {
                    enable = true,
                    max_file_lines = MAX_FILE_LINES,
                    disable = function(_, bufnr)
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
                        if ok and stats and stats.size > MAX_FILE_SIZE then
                            return true
                        end
                    end,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = "<nop>",
                        node_decremental = "<bs>",
                    },
                },
            }
        end,
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
        opts = function()
            local ai = require "mini.ai"
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
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
        config = function(_, opts)
            require("mini.ai").setup(opts)
            local i = {
                [" "] = "Whitespace",
                ['"'] = 'Balanced "',
                ["'"] = "Balanced '",
                ["`"] = "Balanced `",
                ["("] = "Balanced (",
                [")"] = "Balanced ) including white-space",
                [">"] = "Balanced > including white-space",
                ["<lt>"] = "Balanced <",
                ["]"] = "Balanced ] including white-space",
                ["["] = "Balanced [",
                ["}"] = "Balanced } including white-space",
                ["{"] = "Balanced {",
                ["?"] = "User Prompt",
                _ = "Underscore",
                a = "Argument",
                b = "Balanced ), ], }",
                c = "Class",
                f = "Function",
                o = "Block, conditional, loop",
                q = "Quote `, \", '",
                t = "Tag",
            }
            local a = vim.deepcopy(i)
            for k, v in pairs(a) do
                a[k] = v:gsub(" including.*", "")
            end

            local ic = vim.deepcopy(i)
            local ac = vim.deepcopy(a)
            for key, name in pairs { n = "Next", l = "Last" } do
                i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
                a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
            end
            require("which-key").register { mode = { "o", "x" }, i = i, a = a }
        end,
    },

    {
        "echasnovski/mini.surround",
        opts = {
            search_method = "cover",
            highlight_duration = 500,
            mappings = {
                add = "gza",
                delete = "ds",
                replace = "cs",
                highlight = "",
                find = "",
                find_left = "",
                update_n_lines = "",
            },
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },

    {
        "echasnovski/mini.comment",
        event = "BufReadPre",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            require("mini.comment").setup {
                hooks = { pre = require("ts_context_commentstring.internal").update_commentstring },
            }
        end,
    },
}
