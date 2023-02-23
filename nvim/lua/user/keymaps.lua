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
        ["y"] = { '"+y' },
        ["Y"] = { '"+Y' },
        ["p"] = { '"+p' },
        ["P"] = { '"+P' },
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
        ["<C-s>"] = { "<cmd> w <cr>", "Save file" },
        -- navigation
        ["<C-h>"] = { "<left>" },
        ["<C-j>"] = { "<down>" },
        ["<C-k>"] = { "<up>" },
        ["<C-l>"] = { "<right>" },
    },
    -- stylua: ignore
    n = {
        -- quit
        ["<leader>qa"] = {"<cmd> qall <cr>", "Quit all"},
        ["<leader>qA"] = {"<cmd> qall! <cr>", "Quit force all"},
        ["<leader>qq"] = {"<cmd> q <cr>", "Quit window"},
        ["<leader>qQ"] = {"<cmd> q! <cr>", "Quit force window"},
        -- splits
        ["<leader>wv"] = {"<cmd> vsplit <cr>", "Vertical split"},
        ["<leader>wx"] = {"<cmd> split <cr>", "Horizontal split"},
        ["<leader>we"] = {"<C-w>=", "Equalize splits"},
        -- ui reset
        ["<leader>ur"] = { "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><cr>", "Redraw / clear hlsearch / diff update"},
        -- go to last selected text
        ["gV"] = { '"`[" . strpart(getregtype(), 0, 1) . "`]"', "Visually select changed text", opts = { expr = true }, },
        -- emtpy lines
        ["go"] = { "<cmd>call append(line('.'),     repeat([''], v:count1))<cr>", "Put empty line below", },
        ["gO"] = { "<cmd>call append(line('.') - 1, repeat([''], v:count1))<cr>", "Put empty line below", },
        -- file operations
        ["<leader>wf"] = { "<cmd>enew<cr>", "Open a new file" },
        -- remove highlight
        ["<ESC>"] = { "<cmd> noh <cr>", "Remove highlight" },
        -- Resize with arrows
        ["<C-Up>"] = { ":resize +2<cr>", "Resize window up" },
        ["<C-Down>"] = { ":resize -2<cr>", "Resize window down" },
        ["<C-Left>"] = { ":vertical resize +2<cr>", "Resize window left" },
        ["<C-Right>"] = { ":vertical resize -2<cr>", "Resize window right" },
        -- save file
        ["<C-s>"] = { "<cmd> w <cr>", "Save file" },
        -- toggle line numbers
        ["<leader>tr"] = { "<cmd> set rnu! <cr>", "Toggle relative line numbers" },
        -- toggle word wrap 
        ["<leader>tw"] = { "<cmd> set wrap! <cr>", "Toggle word wrap" },
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
        ["<leader>s"] = { ":sort<cr>", "Sort ascending" },
        ["<leader>S"] = { ":sort!<cr>", "Sort descending" },
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

M.telescope = {
    -- stylua: ignore
    n = {
        ["<leader>:"] = { "<cmd> Telescope command_history <cr>", "Command history" },
        ["<leader>/"] = { utils.telescope "live_grep", "Live grep" },
        ["<leader>ff"] = { utils.telescope "files", "Files (root)" },
        ["<leader>fF"] = { utils.telescope("files", { cwd = false }), "Files (cwd)" },
        ["<leader>fw"] = { utils.telescope "live_grep", "Live grep (root)" },
        ["<leader>fW"] = { utils.telescope("live_grep", { cwd = false }), "Live grep (cwd)" },
        ["<leader>fn"] = { "<cmd> Telescope file_browser path=%:p:h <cr>", "File browser (local)" },
        ["<leader>fN"] = { "<cmd> Telescope file_browser <cr>", "File browser (root)" },
        ["<leader>fb"] = { "<cmd> Telescope buffers <cr>", "Buffers" },
        ["<leader>fo"] = { "<cmd> Telescope oldfiles <cr>", "Recent files" },
        ["<leader>gc"] = { "<cmd> Telescope git_commits <cr>", "Git commits" },
        ["<leader>gg"] = { "<cmd> Telescope git_status <cr>", "Git status" },
        ["<leader>xf"] = { "<cmd> Telescope diagnostics <cr>", "Diagnostics" },
        ["<leader>sa"] = { "<cmd>Telescope autocommands <cr>", "Autocommands" },
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

M.rename = {
    -- stylua: ignore
    n = {
        ["<leader>cr"] = { function() return ":IncRename " .. vim.fn.expand "<cword>" end, "Rename", opts = { expr = true }, },
    },
}

M.lsp = {
    -- stylua: ignore
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
        ["<leader>cf"] = { function() vim.lsp.buf.format { async = true } end, "Format", },
        ["<leader>wa"] = { function() vim.lsp.buf.add_workspace_folder() end, "Add workspace folder", },
        ["<leader>wr"] = { function() vim.lsp.buf.remove_workspace_folder() end, "Remove workspace folder", },
        ["<leader>wl"] = { function() utils.notify(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "Workspace list", },
    },
}

M.glance = {
    n = {
        ["gr"] = { "<cmd>Glance references<cr>", "References" },
        ["gM"] = { "<cmd>Glance implementations<cr>", "Implementations" },
        ["gd"] = { "<cmd>Glance definitions<cr>", "Definitions" },
        ["D"] = { "<cmd>Glance type_definitions<cr>", "Type definitions" },
    },
}

M.gitsigns = {
    [{ "o", "x" }] = {
        ["ih"] = { ":<C-U> Gitsigns select_hunk <cr>", "Select hunk", { silent = true } },
    },
    -- stylua: ignore
    ["n"] = {
        ["<leader>tgs"] = { "<cmd> Gitsigns toggle_signs <cr>", "Toggle git signs" },
        ["<leader>tgn"] = { "<cmd> Gitsigns toggle_numhl <cr>", "Toggle git numhl" },
        ["<leader>tgl"] = { "<cmd> Gitsigns toggle_linehl <cr>", "Toggle git linehl" },
        ["<leader>tgw"] = { "<cmd> Gitsigns toggle_word_diff <cr>", "Toggle git diff" },
        ["<leader>tgb"] = { "<cmd> Gitsigns toggle_current_line_blame <cr>", "Toggle git line blame" },
        ["<leader>gs"] = { "<cmd> Gitsigns stage_hunk <cr>", "Stage hunk" },
        ["<leader>gr"] = { "<cmd> Gitsigns reset_hunk <cr>", "Reset hunk" },
        ["<leader>gu"] = { "<cmd> Gitsigns undo_stage_hunk <cr>", "Undo stage hunk" },
        ["<leader>gp"] = { "<cmd> Gitsigns preview_hunk <cr>", "Preview hunk" },
        ["<leader>gS"] = { "<cmd> Gitsigns stage_buffer <cr>", "Stage buffer" },
        ["<leader>gR"] = { "<cmd> Gitsigns reset_buffer <cr>", "Reset buffer" },
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

M.illuminate = {
    -- stylua: ignore
    n = {
        ["]]"] = { function() require("illuminate").goto_next_reference(false) end, "Next reference", },
        ["[["] = { function() require("illuminate").goto_prev_reference(false) end, "Prev reference", },
    },
}

M.navigator = {
    [{ "n", "t" }] = {
        ["<C-h>"] = { "<cmd> NavigatorLeft <cr>", "Navigate left" },
        ["<C-j>"] = { "<cmd> NavigatorDown <cr>", "Navigate down" },
        ["<C-k>"] = { "<cmd> NavigatorUp <cr>", "Navigate up" },
        ["<C-l>"] = { "<cmd> NavigatorRight <cr>", "Navigate right" },
    },
}

M.hop = {
    n = {
        ["<leader>k"] = { "<cmd>HopWordBC<cr>", "Hop word up" },
        ["<leader>j"] = { "<cmd>HopWordAC<cr>", "Hop word down" },
    },
}

M.trouble = {
    -- stylua: ignore
    n = {
        ["<leader>xx"] = { "<cmd> TroubleToggle <cr>", "Toggle trouble" },
        ["<leader>xd"] = { "<cmd> TroubleToggle document_diagnostics <cr>", "Document diagnostics", },
        ["<leader>xD"] = { "<cmd> TroubleToggle workspace_diagnostics <cr>", "Workspace diagnostics", },
        ["<leader>xl"] = { "<cmd> TroubleToggle loclist <cr>", "Loclist" },
        ["<leader>xq"] = { "<cmd> TroubleToggle quickfix <cr>", "Quickfix" },
    },
}

M.toggleterm = {
    n = {
        ["<leader>g\\"] = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
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
        ["<C-n>"] = { "<cmd> NvimTreeToggle <cr>", "Toggle tree" },
    },
}

M.dap = {
    -- stylua: ignore
    n = {
        ["<leader>dc"] = { function() require("dap").continue() end, "DAP continue", },
        ["<leader>dd"] = { function() require("dap").disconnect() end, "DAP disconnect", },
        ["<leader>dk"] = { function() require("dap").up() end, "DAP up", },
        ["<leader>dj"] = { function() require("dap").down() end, "DAP down", },
        ["<leader>du"] = { function() require("dap").step_over() end, "DAP step over", },
        ["<leader>di"] = { function() require("dap").step_into() end, "DAP step into", },
        ["<leader>do"] = { function() require("dap").step_out() end, "DAP step out", },
        ["<leader>ds"] = { function() require("dap").close() end, "DAP close", },
        ["<leader>dn"] = { function() require("dap").run_to_cursor() end, "DAP run to cursor", },
        ["<leader>de"] = { function() require("dap").set_exception_breakpoints() end, "DAP set exception breakpoints", },
        ["<leader>db"] = { function() require("dap").toggle_breakpoint() end, "DAP toggle breakpoint", },
        ["<leader>dD"] = { function() require("dap").clear_breakpoints() end, "DAP clear breakpoints", },
    },
}

M.dapui = {
    -- stylua: ignore
    n = {
        ["<leader>dt"] = { function() require("dapui").toggle() end, "DAP ui toggle", },
        ["<leader>dT"] = { function() require("dapui").close() end, "DAP ui close", },
        ["<leader>df"] = { function() require("dapui").float_element() end, "DAP ui float", },
    },
}

M.neotree = {
    n = {
        ["<C-n>"] = {
            function()
                require("neo-tree.command").execute { toggle = true, dir = vim.loop.cwd() }
            end,
            "Neotree",
        },
    },
}

M.spectre = {
    n = {
        ["<leader>cR"] = { "<cmd> Spectre <cr>", "Replace in files (Spectre)" },
    },
}

M.window_picker = {
    n = {
        ["<leader>ws"] = {
            function()
                local picked_window_id = require("window-picker").pick_window {
                    include_current_win = true,
                } or vim.api.nvim_get_current_win()
                vim.api.nvim_set_current_win(picked_window_id)
            end,
            "Pick a window",
        },
        ["<leader>wS"] = {
            function()
                local window = require("window-picker").pick_window { include_current_win = false }
                if window == nil then
                    return
                end
                local target_buffer = vim.fn.winbufnr(window)
                vim.api.nvim_win_set_buf(window, 0)
                vim.api.nvim_win_set_buf(0, target_buffer)
            end,
            "Swap windows",
        },
    },
}

M.neogen = {
    n = {
        ["<leader>cg"] = { "<cmd>lua require('neogen').generate()<cr>", "Generate doc" },
    },
}

M.undotree = {
    n = {
        ["<leader>fu"] = { "<cmd> UndotreeToggle <cr>", "Toggle undotree" },
    },
}

return M
