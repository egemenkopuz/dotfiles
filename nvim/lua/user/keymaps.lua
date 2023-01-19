local M = {}

M.general = {
    i = {
        -- to quit insert mode fast
        ["jk"] = { "<ESC>", "Leave insert mode" },
        ["kj"] = { "<ESC>", "Leave insert mode" },
        ["jj"] = { "<ESC>", "Leave insert mode" },
        -- go to beginning of line
        ["<C-b>"] = { "<ESC>^i", "Go to beginning of line" },
        -- go to end of line
        ["<C-e>"] = { "<End>", "Go to end of line" },
        -- save file
        ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
    },
    n = {
        -- remove highlight
        ["<ESC>"] = { "<cmd> noh <CR>", "Remove highlight" },
        -- Resize with arrows
        ["<C-Up>"] = { ":resize +2<CR>", "Resize window up" },
        ["<C-Down>"] = { ":resize -2<CR>", "Resize window down" },
        ["<C-Left>"] = { ":vertical resize +2<CR>", "Resize window left" },
        ["<C-Right>"] = { ":vertical resize -2<CR>", "Resize window right" },
        -- save file
        ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
        -- line numbers
        ["<leader>tr"] = { "<cmd> set rnu! <CR>", "Toggle relative line numbers" },
        -- centered page navigation
        ["<C-u>"] = { "<C-u>zz", "Jump half-page up" },
        ["<C-d>"] = { "<C-d>zz", "Jump half-page down" },
        -- centered search navigation
        ["n"] = { "nzzzv", "Next searched" },
        ["N"] = { "Nzzzv", "Previous searched" },
        -- better pasting
        ["[p"] = { ":pu!<cr>" },
        ["]p"] = { ":pu<cr>" },
    },
    v = {
        -- indenting
        ["<"] = { "<gv", "Indent left" },
        [">"] = { ">gv", "Indent right" },
        -- sorting
        ["<leader>s"] = { ":sort<CR>", "Sort ascending" },
        ["<leader>S"] = { ":sort!<CR>", "Sort descending" },
    },
}

M.treesitter_context = {
    n = {
        ["<leader>tc"] = { "<cmd> TSContextToggle <cr>", "Toggle treesitter context" },
    },
}

M.telescope = {
    n = {
        ["<leader>ff"] = {
            function()
                local status = pcall(vim.cmd, "Telescope git_files")
                if not status then
                    vim.cmd "Telescope find_files"
                end
            end,
            "Find files",
        },
        ["<leader>fa"] = {
            "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <cr>",
            "Find file global",
        },
        ["<leader>fw"] = { "<cmd> Telescope live_grep <cr>", "Live grep" },
        ["<leader>fb"] = { "<cmd> Telescope buffers <cr>", "Buffers" },
        ["<leader>fh"] = { "<cmd> Telescope help_tags <cr>", "Help tags" },
        ["<leader>fo"] = { "<cmd> Telescope oldfiles <cr>", "Old files" },
        ["<leader>fk"] = { "<cmd> Telescope keymaps <cr>", "Key maps" },
        ["<leader>gc"] = { "<cmd> Telescope git_commits <cr>", "Git commit" },
        ["<leader>gg"] = { "<cmd> Telescope git_status <cr>", "Git status" },
        ["<leader>dl"] = { "<cmd> Telescope diagnostics <cr>", "Diagnostics" },
    },
}

-- stylua: ignore start
M.rename = {
    n = {
        ["<leader>cr"] = { function() return ":IncRename " .. vim.fn.expand "<cword>" end, "Rename", opts = { expr = true }, },
    },
}
-- stylua: ignore end

-- stylua: ignore start
M.lsp = {
    n = {
        ["gD"] = { function() vim.lsp.buf.declaration() end, "Go to declaration", },
        ["K"] = { function() vim.lsp.buf.hover() end, "Open hover", },
        ["<leader>ls"] = { function() vim.lsp.buf.signature_help() end, "Signature help", },
        ["<leader>ca"] = { function() vim.lsp.buf.code_action() end, "Code action", },
        ["]d"] = { function() vim.diagnostic.goto_next() end, "Next diagnostic", },
        ["[d"] = { function() vim.diagnostic.goto_prev() end, "Previous diagnostic", },
        ["]e"] = { function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR}) end, "Next error", },
        ["[e"] = { function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR}) end, "Previous error", },
        ["]w"] = { function() vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN}) end, "Next warning", },
        ["[w"] = { function() vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN}) end, "Previous warning", },
        ["<leader>q"] = { function() vim.diagnostic.setloclist() end, "Set loc list", },
        ["<leader>cf"] = { function() vim.lsp.buf.format { async = true } end, "Format", },
        ["<leader>wa"] = { function() vim.lsp.buf.add_workspace_folder() end, "Add workspace folder", },
        ["<leader>wr"] = { function() vim.lsp.buf.remove_workspace_folder() end, "Remove workspace folder", },
        ["<leader>wl"] = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "Workspace list", },
    },
}
-- stylua: ignore end

M.glance = {
    n = {
        ["gr"] = { "<cmd>Glance references<CR>", "References" },
        ["gM"] = { "<cmd>Glance implementations<CR>", "Implementations" },
        ["gd"] = { "<cmd>Glance definitions<CR>", "Definitions" },
        ["D"] = { "<cmd>Glance type_definitions<CR>", "Type definitions" },
    },
}

-- stylua: ignore start
M.gitsigns = {
    [{ "o", "x" }] = {
        ["ih"] = { ":<C-U> Gitsigns select_hunk <CR>", "Select hunk", { silent = true } },
    },
    ["n"] = {
        ["<leader>ts"] = { "<cmd> Gitsigns toggle_signs <CR>", "Toggle git signs" },
        ["<leader>tn"] = { "<cmd> Gitsigns toggle_numhl <CR>", "Toggle git numhl" },
        ["<leader>tl"] = { "<cmd> Gitsigns toggle_linehl <CR>", "Toggle git linehl" },
        ["<leader>tw"] = { "<cmd> Gitsigns toggle_word_diff <CR>", "Toggle git diff" },
        ["<leader>gs"] = { "<cmd> Gitsigns stage_hunk <CR>", "Stage hunk" },
        ["<leader>gr"] = { "<cmd> Gitsigns reset_hunk <CR>", "Reset hunk" },
        ["<leader>gu"] = { "<cmd> Gitsigns undo_stage_hunk <CR>", "Undo stage hunk" },
        ["<leader>gp"] = { "<cmd> Gitsigns preview_hunk <CR>", "Preview hunk" },
        ["<leader>gS"] = { "<cmd> Gitsigns stage_buffer <CR>", "Stage buffer" },
        ["<leader>gR"] = { "<cmd> Gitsigns reset_buffer <CR>", "Reset buffer" },
        ["<leader>gl"] = { function() require("gitsigns").blame_line { full = true } end, "Blame line", },
        ["[h"] = {
            function()
                if vim.wo.diff then return "[h" end
                vim.schedule(function() require("gitsigns").prev_hunk() end)
                return "<Ignore>"
            end,
            "Previous hunk",
            opts = { expr = true },
        },
        ["]h"] = {
            function()
                if vim.wo.diff then return "]h" end
                vim.schedule(function() require("gitsigns").next_hunk() end)
                return "<Ignore>"
            end,
            "Next hunk",
            opts = { expr = true },
        },
    },
}
-- stylua: ignore end

M.navigator = {
    [{ "n", "t" }] = {
        ["<C-h>"] = { "<cmd> NavigatorLeft <cr>", "Navigate left" },
        ["<C-j>"] = { "<cmd> NavigatorDown <cr>", "Navigate down" },
        ["<C-k>"] = { "<cmd> NavigatorUp <cr>", "Navigate up" },
        ["<C-l>"] = { "<cmd> NavigatorRight <cr>", "Navigate right" },
    },
}

M.illuminate = {
    ["n"] = {
        ["]]"] = {
            function()
                require("illuminate").goto_next_reference(false)
            end,
            "Next reference",
        },
        ["[["] = {
            function()
                require("illuminate").goto_prev_reference(false)
            end,
            "Prev reference",
        },
    },
}

return M
