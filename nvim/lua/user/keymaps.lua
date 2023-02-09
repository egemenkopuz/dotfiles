local M = {}

local utils = require "user.utils"

M.general = {
    [{ "n", "x" }] = {
        ["j"] = { [[v:count == 0 ? 'gj' : 'j']], opts = { expr = true } },
        ["k"] = { [[v:count == 0 ? 'gk' : 'k']], opts = { expr = true } },
        ["d"] = { '"_d' },
        ["D"] = { '"_D' },
        ["c"] = { '"_c' },
        ["C"] = { '"_C' },
    },
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
        -- navigation
        ["<C-h>"] = { "<left>" },
        ["<C-j>"] = { "<down>" },
        ["<C-k>"] = { "<up>" },
        ["<C-l>"] = { "<right>" },
    },
    -- stylua: ignore
    n = {
        ["go"] = { "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", "Put empty line below", },
        ["gO"] = { "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", "Put empty line below", },
        ["<leader>fN"] = { "<cmd>enew<cr>", "Open a new file" },
        ["gV"] = { '"`[" . strpart(getregtype(), 0, 1) . "`]"', "Visually select changed text", opts = { expr = true }, },
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
        -- buffer navigation
        ["]b"] = { ":bnext <cr>" },
        ["[b"] = { ":bprevious <cr>" },
        -- toggle diagnostic
        ["<leader>td"] = { function() utils.toggle_diagnostics() end, "Toggle diagnostics", },
        -- toggle format on save
        ["<leader>tf"] = { function() utils.toggle_autoformat() end, "Toggle autoformat", },
        -- toggle color column
        ["<leader>tc"] = { function() utils.toggle_colorcolumn() end, "Toggle colorcolumn", },
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

M.bufremove = {
    n = {
        ["<leader>bd"] = { "<cmd> Bdelete <cr>", "Kill buffer" },
        ["<leader>bD"] = { "<cmd> Bdelete! <cr>", "Kill force buffer" },
    },
}

M.zenmode = {
    n = {
        ["<leader>tz"] = { "<cmd> NoNeckPain <cr>", "Toggle zen mode" },
    },
}

M.treesitter_context = {
    n = {
        ["<leader>tt"] = { "<cmd> TSContextToggle <cr>", "Toggle treesitter context" },
    },
}

-- stylua: ignore start
M.telescope = {
    n = {
        ["<leader>:"] = { "<cmd> Telescope command_history <cr>", "Command history" },
        ["<leader>/"] = { utils.telescope "live_grep", "Live grep" },
        ["<leader>ff"] = { utils.telescope "files", "Files (root)" },
        ["<leader>fF"] = { utils.telescope("files", { cwd = false }), "Files (cwd)" },
        ["<leader>fw"] = { utils.telescope "live_grep", "Live grep" },
        ["<leader>fn"] = { "<cmd> Telescope file_browser <cr>", "File browser" },
        ["<leader>fb"] = { "<cmd> Telescope buffers <cr>", "Buffers" },
        ["<leader>fo"] = { "<cmd> Telescope oldfiles <cr>", "Old files" },
        ["<leader>gc"] = { "<cmd> Telescope git_commits <cr>", "Git commit" },
        ["<leader>gg"] = { "<cmd> Telescope git_status <cr>", "Git status" },
        ["<leader>xf"] = { "<cmd> Telescope diagnostics <cr>", "Diagnostics" },
        ["<leader>sa"] = { "<cmd>Telescope autocommands <cr>", "Auto commands" },
        ["<leader>sc"] = { "<cmd> Telescope command_history <cr>", "Command history" },
        ["<leader>sC"] = { "<cmd> Telescope commands <cr>", "Commands" },
        ["<leader>sd"] = { "<cmd> Telescope diagnostics <cr>", "Diagnostics" },
        ["<leader>sh"] = { "<cmd>Telescope help_tags<cr>", "Help Pages" },
        ["<leader>sH"] = { "<cmd>Telescope highlights<cr>", "Search highlight groups" },
        ["<leader>sk"] = { "<cmd>Telescope keymaps<cr>", "Key maps" },
        ["<leader>sM"] = { "<cmd>Telescope man_pages<cr>", "Man pages" },
        ["<leader>sm"] = { "<cmd>Telescope marks<cr>", "Jump to mark" },
        ["<leader>so"] = { "<cmd>Telescope vim_options<cr>", "Options" },
        ["<leader>sw"] = { utils.telescope "grep_string", "Word (root dir)" },
        ["<leader>sW"] = { utils.telescope("grep_string", { cwd = false }), "Word (cwd)" },
        ["<leader>ss"] = {
            utils.telescope("lsp_document_symbols", {
                symbols = {
                    "Class",
                    "Function",
                    "Method",
                    "Constructor",
                    "Interface",
                    "Module",
                    "Struct",
                    "Trait",
                    "Field",
                    "Property",
                },
            }),
            "LSP symbols",
        },
    },
}
-- stylua: ignore end

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
        ["<leader>wl"] = { function() utils.notify(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "Workspace list", },
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
        ["<leader>tb"] = { "<cmd> Gitsigns toggle_current_line_blame <CR>", "Toggle git line blame" },
        ["<leader>gs"] = { "<cmd> Gitsigns stage_hunk <CR>", "Stage hunk" },
        ["<leader>gr"] = { "<cmd> Gitsigns reset_hunk <CR>", "Reset hunk" },
        ["<leader>gu"] = { "<cmd> Gitsigns undo_stage_hunk <CR>", "Undo stage hunk" },
        ["<leader>gp"] = { "<cmd> Gitsigns preview_hunk <CR>", "Preview hunk" },
        ["<leader>gS"] = { "<cmd> Gitsigns stage_buffer <CR>", "Stage buffer" },
        ["<leader>gR"] = { "<cmd> Gitsigns reset_buffer <CR>", "Reset buffer" },
        ["<leader>gl"] = { function() require("gitsigns").blame_line { full = true } end, "Blame line", },
        ["[h"] = {
            function()
                if vim.wo.diff then return "[h" end vim.schedule(function() require("gitsigns").prev_hunk() end) return "<Ignore>"
            end,
            "Previous hunk", opts = { expr = true },
        },
        ["]h"] = {
            function()
                if vim.wo.diff then return "]h" end vim.schedule(function() require("gitsigns").next_hunk() end) return "<Ignore>"
            end,
            "Next hunk", opts = { expr = true },
        },
    },
}
-- stylua: ignore end

M.illuminate = {
    n = {
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

M.navigator = {
    [{ "n", "t" }] = {
        ["<C-h>"] = { "<cmd> NavigatorLeft <CR>", "Navigate left" },
        ["<C-j>"] = { "<cmd> NavigatorDown <CR>", "Navigate down" },
        ["<C-k>"] = { "<cmd> NavigatorUp <CR>", "Navigate up" },
        ["<C-l>"] = { "<cmd> NavigatorRight <CR>", "Navigate right" },
    },
}

M.hop = {
    n = {
        ["<leader>k"] = { "<cmd>HopWordBC<CR>", "Hop word up" },
        ["<leader>j"] = { "<cmd>HopWordAC<CR>", "Hop word down" },
    },
}

-- stylua: ignore start
M.trouble = {
    n = {
        ["<leader>xx"] = { "<cmd> TroubleToggle <CR>", "Toggle trouble" },
        ["<leader>xd"] = { "<cmd> TroubleToggle document_diagnostics <CR>", "Document diagnostics", },
        ["<leader>xD"] = { "<cmd> TroubleToggle workspace_diagnostics <CR>", "Workspace diagnostics", },
        ["<leader>xl"] = { "<cmd> TroubleToggle loclist <CR>", "Loclist" },
        ["<leader>xq"] = { "<cmd> TroubleToggle quickfix <CR>", "Quickfix" },
    },
}
-- stylua: ignore end

M.toggleterm = {
    n = {
        ["<leader>g\\"] = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    },
    t = {
        ["<C-x>"] = {
            vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
            "Close terminal",
        },
    },
}

M.nvimtree = {
    n = {
        ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle tree" },
    },
}

-- stylua: ignore start
M.dap = {
    n = {
        ["<leader>dc"] = { function() require("dap").continue() end, "DAP continue", },
        ["<leader>dd"] = { function() require("dap").disconnect() end, "DAP disconnect", },
        ["<leader>dk"] = { function() require("dap").up() end, "DAP up", },
        ["<leader>dj"] = { function() require("dap").down() end, "DAP down", },
        ["<leader>du"] = { function() require("dap").step_over() end, "DAP step over", },
        ["<leader>di"] = { function() require("dap").step_into() end, "DAP step into", },
        ["<leader>do"] = { function() require("dap").step_out() end, "DAP step out", },
        ["<leader>ds"] = { function() require("dap").stop() end, "DAP stop", },
        ["<leader>dn"] = { function() require("dap").run_to_cursor() end, "DAP run to cursor", },
        ["<leader>de"] = { function() require("dap").set_exception_breakpoints() end, "DAP set exception breakpoints", },
        ["<leader>db"] = { function() require("dap").toggle_breakpoint() end, "DAP toggle breakpoint", },
    },
}

M.dapui = {
    n = {
        ["<leader>dt"] = { function() require("dapui").toggle() end, "DAP ui toggle", },
        ["<leader>dT"] = { function() require("dapui").close() end, "DAP ui close", },
        ["<leader>df"] = { function() require("dapui").float_element() end, "DAP ui float", },
    },
}
-- stylua: ignore end

return M
