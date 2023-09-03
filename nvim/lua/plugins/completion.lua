return {
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            {
                "L3MON4D3/LuaSnip",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
                opts = { history = true, delete_check_events = "TextChanged" },
                -- stylua: ignore
                keys = {
                    { "<tab>", function() return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end, expr = true, silent = true, mode = "i", },
                    { "<tab>", function() require("luasnip").jump(1) end, mode = "s", },
                    { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, },
                },
            },
            "saadparwaiz1/cmp_luasnip",
            "zbirenbaum/copilot-cmp",
        },
        opts = function()
            local cmp = require "cmp"
            local cmp_window = require "cmp.utils.window"

            cmp_window.info_ = cmp_window.info
            cmp_window.info = function(self)
                local info = self:info_()
                info.scrollable = false
                return info
            end

            local function border(hl_name)
                return {
                    { "┌", hl_name },
                    { "─", hl_name },
                    { "┐", hl_name },
                    { "│", hl_name },
                    { "┘", hl_name },
                    { "─", hl_name },
                    { "└", hl_name },
                    { "│", hl_name },
                }
            end

            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
                    return false
                end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api
                            .nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
                            :match "^%s*$"
                        == nil
            end
            return {
                window = {
                    completion = {
                        border = border "CmpBorder",
                        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
                    },
                    documentation = { border = border "CmpDocBorder" },
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    },
                    ["<Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item { behavior = cmp.SelectBehavior }
                        else
                            fallback()
                        end
                    end),
                    ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_prev_item { behavior = cmp.SelectBehavior }
                        else
                            fallback()
                        end
                    end),
                },
                sources = cmp.config.sources {
                    { name = "copilot", group_index = 2 },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "path" },
                },
                formatting = {
                    format = function(_, item)
                        local icons = require("user.config").icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end,
                },
                formatters = { insert_text = require("copilot_cmp.format").remove_existing },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        require("copilot_cmp.comparators").prioritize,
                        require("copilot_cmp.comparators").score,
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                experimental = { ghost_text = { hl_group = "LspCodeLens" } },
            }
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        dependencies = {
            "zbirenbaum/copilot.lua",
            opts = { suggestion = { enabled = false }, panel = { enabled = false } },
        },
        opts = { method = "getCompletionsCycling" },
        config = function(_, opts)
            require("copilot_cmp").setup(opts)
        end,
    },
}
