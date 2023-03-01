return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker",
        },
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            require("user.utils").load_keymap "neotree"
        end,
        opts = {
            filesystem = {
                use_libuv_file_watcher = true,
                bind_to_cwd = false,
                follow_current_file = true,
                hijack_netrw_behavior = "disabled",
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                    ["<2-LeftMouse>"] = "open_with_window_picker",
                    ["<cr>"] = "open_with_window_picker",
                    ["<C-x>"] = "split_with_window_picker",
                    ["<C-v>"] = "vsplit_with_window_picker",
                },
            },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "olimorris/persisted.nvim",
            "ahmedkhalf/project.nvim",
            "folke/noice.nvim",
        },
        cmd = "Telescope",
        version = false,
        init = function()
            require("project_nvim").setup()
            require("user.utils").load_keymap "telescope"
        end,
        opts = {
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                    "--glob",
                    "!**/.git/*",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = { mirror = false },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                path_display = { "truncate" },
                winblend = 0,
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                file_browser = { hijack_netrw = false, hidden = true, use_fd = true },
            },
        },
        config = function(_, opts)
            local telescope = require "telescope"

            vim.g.theme_switcher_loaded = true

            opts.extensions["ui-select"] = {
                require("telescope.themes").get_dropdown {
                    layout_strategy = "vertical",
                    layout_config = {
                        prompt_position = "top",
                        vertical = { width = 0.4, height = 0.3 },
                    },
                },
            }

            telescope.setup(opts)

            telescope.load_extension "fzf"
            telescope.load_extension "file_browser"
            telescope.load_extension "ui-select"
            telescope.load_extension "projects"
            telescope.load_extension "persisted"
            telescope.load_extension "noice"

            local tc1 = "#2E3440"
            local tc2 = "#ABFFF5"
            local tc3 = "#191C24"
            local tc4 = "#F38BA8"

            local hl_group = {
                TelescopeMatching = { fg = tc2 },
                TelescopeSelection = { fg = tc2, bg = tc1 },
                TelescopePromptTitle = { fg = tc3, bg = tc4, bold = true },
                TelescopePromptPrefix = { fg = tc2 },
                TelescopePromptCounter = { fg = tc2 },
                TelescopePromptNormal = { bg = tc1 },
                TelescopePromptBorder = { fg = tc1, bg = tc1 },
                TelescopeResultsTitle = { fg = tc3, bg = tc3, bold = true },
                TelescopeResultsNormal = { bg = tc3 },
                TelescopeResultsBorder = { fg = tc3, bg = tc3 },
                TelescopePreviewTitle = { fg = tc3, bg = tc2, bold = true },
                TelescopePreviewNormal = { bg = tc3 },
                TelescopePreviewBorder = { fg = tc3, bg = tc3 },
            }

            for k, v in pairs(hl_group) do
                vim.api.nvim_set_hl(0, k, v)
            end
        end,
    },

    {
        "s1n7ax/nvim-window-picker",
        event = "BufReadPost",
        version = "v1.*",
        config = function()
            require("window-picker").setup {
                autoselect_one = true,
                include_current = false,
                other_win_hl_color = "#7E9CD8",
                filter_rules = {
                    bo = {
                        filetype = { "neo-tree", "neo-tree-popup", "notify", "no-neck-pain" },
                        buftype = { "terminal", "quickfix" },
                    },
                },
            }
            require("user.utils").load_keymap "window_picker"
        end,
    },

    {
        "numToStr/Navigator.nvim",
        config = function(_, opts)
            require("Navigator").setup(opts)
            require("user.utils").load_keymap "navigator"
        end,
    },

    {
        "egemenkopuz/hop.nvim",
        event = "BufReadPre",
        branch = "fix-some-bugs",
        opts = { keys = "etovxqpdygfblzhckisuran" },
        config = function(_, opts)
            require("hop").setup(opts)
            require("user.utils").load_keymap "hop"
        end,
    },

    {
        "ggandor/leap.nvim",
        event = "BufReadPre",
        dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
        config = function(_, opts)
            local leap = require "leap"
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
            vim.keymap.del({ "x", "o" }, "x")
            vim.keymap.del({ "x", "o" }, "X")
        end,
    },

    {
        "echasnovski/mini.bracketed",
        version = false,
        opts = {
            buffer = { suffix = "b", options = {} },
            comment = { suffix = "c", options = {} },
            conflict = { suffix = "x", options = {} },
            diagnostic = { suffix = "d", options = {} },
            file = { suffix = "f", options = {} },
            indent = { suffix = "i", options = {} },
            jump = { suffix = "j", options = {} },
            location = { suffix = "l", options = {} },
            oldfile = { suffix = "o", options = {} },
            quickfix = { suffix = "q", options = {} },
            treesitter = { suffix = "t", options = {} },
            undo = { suffix = "u", options = {} },
            window = { suffix = "w", options = {} },
            yank = { suffix = "y", options = {} },
        },
        config = function(_, opts)
            require("mini.bracketed").setup(opts)
        end,
    },
}
