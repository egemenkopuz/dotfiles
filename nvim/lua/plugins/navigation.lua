return {
    {
        "nvim-tree/nvim-tree.lua",
        enabled = true,
        cmd = {
            "NvimTreeToggle",
            "NvimTreeFocus",
        },
        version = "nightly",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        opts = {
            filters = {
                dotfiles = false,
                exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
                custom = { "^.git$" },
            },
            disable_netrw = true,
            hijack_netrw = true,
            open_on_setup = false,
            ignore_ft_on_setup = { "alpha" },
            hijack_cursor = true,
            hijack_unnamed_buffer_when_opening = false,
            update_cwd = true,
            update_focused_file = {
                enable = true,
                update_cwd = false,
            },
            view = {
                adaptive_size = true,
                side = "left",
                width = 25,
                hide_root_folder = true,
            },
            git = {
                enable = true,
                ignore = true,
            },
            filesystem_watchers = {
                enable = true,
            },
            actions = {
                open_file = {
                    resize_window = true,
                },
            },
            renderer = {
                highlight_git = true,
                highlight_opened_files = "none",

                indent_markers = {
                    enable = false,
                },

                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = false,
                    },

                    glyphs = {
                        default = "",
                        symlink = "",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                            symlink_open = "",
                            arrow_open = "",
                            arrow_closed = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
            },
        },
        init = function()
            require("user.utils").load_keymap "nvimtree"
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "debugloop/telescope-undo.nvim",
            "olimorris/persisted.nvim",
            "ahmedkhalf/project.nvim",
            "folke/noice.nvim",
        },
        cmd = "Telescope",
        version = false,
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
                    vertical = {
                        mirror = false,
                    },
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
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 0.8,
                    },
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                file_browser = {
                    hidden = true,
                    use_fd = true,
                },
            },
        },
        init = function()
            require("user.utils").load_keymap "telescope"
        end,
        config = function(_, opts)
            local telescope = require "telescope"

            vim.g.theme_switcher_loaded = true

            opts.extensions["ui-select"] = {
                require("telescope.themes").get_dropdown {
                    layout_strategy = "vertical",
                    layout_config = {
                        prompt_position = "top",
                        vertical = {
                            width = 0.4,
                            height = 0.3,
                        },
                    },
                },
            }

            telescope.setup(opts)

            telescope.load_extension "fzf"
            telescope.load_extension "undo"
            telescope.load_extension "file_browser"
            telescope.load_extension "ui-select"

            require("project_nvim").setup()
            telescope.load_extension "projects"

            require("persisted").setup()
            telescope.load_extension "persisted"

            require("telescope").load_extension "noice"

            local tc1 = "#2A2B3C"
            local tc2 = "#ABFFF5"
            local tc3 = "#181825"
            local tc4 = "#F38BA8"

            local hl_group = {
                --     TelescopeMatching = { fg = tc2 },
                --     TelescopeSelection = { fg = tc2, bg = tc1 },
                --     TelescopePromptTitle = {
                --         fg = tc3,
                --         bg = tc4,
                --         bold = true,
                --     },
                --     TelescopePromptPrefix = { fg = tc2 },
                --     TelescopePromptCounter = { fg = tc2 },
                --     TelescopePromptNormal = { bg = tc1 },
                --     TelescopePromptBorder = { fg = tc1, bg = tc1 },
                TelescopeResultsTitle = {
                    fg = tc3,
                    bg = tc3,
                    bold = true,
                },
                --     TelescopeResultsNormal = { bg = tc3 },
                --     TelescopeResultsBorder = { fg = tc3, bg = tc3 },
                --     TelescopePreviewTitle = {
                --         fg = tc3,
                --         bg = tc2,
                --         bold = true,
                --     },
                --     TelescopePreviewNormal = { bg = tc3 },
                --     TelescopePreviewBorder = { fg = tc3, bg = tc3 },
            }

            for k, v in pairs(hl_group) do
                vim.api.nvim_set_hl(0, k, v)
            end
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
        "echasnovski/mini.tabline",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        opts = {},
        config = function(_, opts)
            require("mini.tabline").setup(opts)
        end,
    },
}
