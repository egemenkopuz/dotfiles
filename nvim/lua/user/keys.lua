local M = {}

M.general = {
  ["i"] = {
    -- to quit insert mode fast
    ["jk"] = { "<ESC>", "Leave insert mode" },
    ["kj"] = { "<ESC>", "Leave insert mode" },
    ["jj"] = { "<ESC>", "Leave insert mode" },
    -- go to beginning of line
    ["<C-b>"] = { "<ESC>^i", "Go to beginning of line" },
    -- go to end of line
    ["<C-e>"] = { "<End>", "Go to end of line" },
    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Navigate left" },
    ["<C-l>"] = { "<Right>", "Navigate right" },
    ["<C-k>"] = { "<Up>", "Navigate up" },
    ["<C-j>"] = { "<Down>", "Navigate down" },
    -- Move current line / block
    ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", "Move current line/block down" },
    ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", "Move current line/block up" },
  },
  ["n"] = {
    -- remove highlight
    ["<ESC>"] = { "<cmd> noh <CR>", "Remove highlight" },
    -- Resize with arrows
    ["<C-Up>"] = { ":resize -2<CR>", "Resize window up" },
    ["<C-Down>"] = { ":resize +2<CR>", "Resize window down" },
    ["<C-Left>"] = { ":vertical resize -2<CR>", "Resize window left" },
    ["<C-Right>"] = { ":vertical resize +2<CR>", "Resize window right" },
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Switch to left window" },
    ["<C-l>"] = { "<C-w>l", "Switch to right window" },
    ["<C-k>"] = { "<C-w>k", "Switch to upper window" },
    ["<C-j>"] = { "<C-w>j", "Switch to lower window" },
    -- save file
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line numbers" },
    ["<leader>nn"] = { "<cmd> set rnu! <CR>", "Toggle relative line numbers" },
    -- Move current line / block
    ["<A-j>"] = { ":m .+1<CR>==", "Move current line/block down" },
    ["<A-k>"] = { ":m .-2<CR>==", "Move current line/block up" },
    -- select all
    ["<C-a>"] = { "gg<S-v>G", "Select all" },
    -- centered page navigation
    ["<C-u>"] = { "<C-u>zz", "Jump half-page up" },
    ["<C-d>"] = { "<C-d>zz", "Jump half-page down" },
    -- centered search navigation
    ["n"] = { "nzzzv", "Next searched" },
    ["N"] = { "Nzzzv", "Previous searched" },
  },
  ["v"] = {
    -- indenting
    ["<"] = { "<gv", "Indent left" },
    [">"] = { ">gv", "Indent right" },
    -- sorting
    ["<leader>s"] = { ":sort<CR>", "Sort ascending" },
    ["<leader>S"] = { ":sort!<CR>", "Sort descending" },
  },
  ["x"] = {
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = { ":m '>+1<CR>gv-gv", "Move current line/block down" },
    ["<A-k>"] = { ":m '<-2<CR>gv-gv", "Move current line/block up" },
  },
  ["t"] = {},
}

M.comment = {
  ["n"] = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Comment out",
    },
  },

  ["v"] = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lspconfig = {
  ["n"] = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },
    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
    ["<leader>dk"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "LSP go to previous",
    },
    ["<leader>dj"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "LSP go to next",
    },
    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "LSP set loc list",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP format",
    },
    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "LSP add workspace folder",
    },
    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "LSP remove workspace folder",
    },
    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "LSP workspace list",
    },
  },
}

M.telescope = {
  ["n"] = {
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
      "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
      "Find file global",
    },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help tags" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Old files" },
    ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "Key maps" },
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commit" },
    ["<leader>gg"] = { "<cmd> Telescope git_status <CR>", "Git status" },
    ["<leader>dl"] = { "<cmd> Telescope diagnostics <CR>", "Diagnostics" },
  },
}

M.hop = {
  ["n"] = {
    ["<leader>k"] = { "<cmd>HopWordBC<CR>", "Hop word up" },
    ["<leader>j"] = { "<cmd>HopWordAC<CR>", "Hop word down" },
  },
}

M.gitsigns = {
  [{ "o", "x" }] = {
    ["ih"] = { ":<C-U> Gitsigns select_hunk <CR>", "Select hunk", { silent = true } },
  },
  ["n"] = {
    ["<leader>gts"] = { "<cmd> Gitsigns toggle_signs <CR>", "Toggle git signs" },
    ["<leader>gtn"] = { "<cmd> Gitsigns toggle_numhl <CR>", "Toggle git numhl" },
    ["<leader>gtl"] = { "<cmd> Gitsigns toggle_linehl <CR>", "Toggle git linehl" },
    ["<leader>gtw"] = {
      "<cmd> Gitsigns toggle_word_diff <CR>",
      "Toggle git diff",
    },
    ["<leader>gs"] = { "<cmd> Gitsigns stage_hunk <CR>", "Stage hunk" },
    ["<leader>gr"] = { "<cmd> Gitsigns reset_hunk <CR>", "Reset hunk" },
    ["<leader>gu"] = { "<cmd> Gitsigns undo_stage_hunk <CR>", "Undo stage hunk" },
    ["<leader>gp"] = { "<cmd> Gitsigns preview_hunk <CR>", "Preview hunk" },
    ["<leader>gS"] = { "<cmd> Gitsigns stage_buffer <CR>", "Stage buffer" },
    ["<leader>gR"] = { "<cmd> Gitsigns reset_buffer <CR>", "Reset buffer" },
    ["<leader>gl"] = {
      function()
        require("gitsigns").blame_line { full = true }
      end,
      "Blame line",
    },
    ["[h"] = {
      function()
        if vim.wo.diff then
          return "[h"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Previous hunk",
      opts = { expr = true },
    },
    ["]h"] = {
      function()
        if vim.wo.diff then
          return "]h"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Next hunk",
      opts = { expr = true },
    },
  },
}

M.trouble = {
  ["n"] = {
    ["<leader>xx"] = { "<cmd> TroubleToggle <CR>", "toggle trouble" },
    ["<leader>xw"] = {
      "<cmd> TroubleToggle workspace_diagnostics <CR>",
      "Workspace diagnostics",
    },
    ["<leader>xd"] = {
      "<cmd> TroubleToggle document_diagnostics <CR>",
      "Document diagnostics",
    },
    ["<leader>xl"] = { "<cmd> TroubleToggle loclist <CR>", "Loclist" },
    ["<leader>xq"] = { "<cmd> TroubleToggle quickfix <CR>", "Quickfix" },
  },
}

M.glance = {
  ["n"] = {
    ["gr"] = { "<cmd>Glance references<CR>", "LSP references" },
    ["gM"] = {
      "<cmd>Glance implementations<CR>",
      "LSP implementations",
    },
    ["gd"] = { "<cmd>Glance definitions<CR>", "LSP definitions" },
    ["D"] = {
      "<cmd>Glance type_definitions<CR>",
      "LSP type definitions",
    },
  },
}

M.rename = {
  ["n"] = {
    ["<leader>rn"] = {
      function()
        return ":IncRename " .. vim.fn.expand "<cword>"
      end,
      "rename",
      opts = { expr = true },
    },
  },
}

M.bufferline = {
  ["n"] = {
    ["<leader>bd"] = { "<cmd> BufferKill <CR>", "Buffer kill" },
    ["[b"] = { "<cmd> BufferLineCyclePrev<CR>", "Cycle buffer prev" },
    ["]b"] = { "<cmd> BufferLineCycleNext<CR>", "Cycle buffer next" },
    ["<leader>[m"] = { "<cmd> BufferLineMovePrev<CR>", "Move buffer left" },
    ["<leader>]m"] = { "<cmd> BufferLineMoveNext<CR>", "Move buffer right" },
    ["<leader>1"] = {
      function()
        require("bufferline").go_to_buffer(1, true)
      end,
      "Buffer 1",
    },
    ["<leader>2"] = {
      function()
        require("bufferline").go_to_buffer(2, true)
      end,
      "Buffer 2",
    },
    ["<leader>3"] = {
      function()
        require("bufferline").go_to_buffer(3, true)
      end,
      "Buffer 3",
    },
    ["<leader>4"] = {
      function()
        require("bufferline").go_to_buffer(4, true)
      end,
      "Buffer 4",
    },
    ["<leader>5"] = {
      function()
        require("bufferline").go_to_buffer(5, true)
      end,
      "Buffer 5",
    },
    ["<leader>6"] = {
      function()
        require("bufferline").go_to_buffer(6, true)
      end,
      "Buffer 6",
    },
    ["<leader>7"] = {
      function()
        require("bufferline").go_to_buffer(7, true)
      end,
      "Buffer 7",
    },
    ["<leader>8"] = {
      function()
        require("bufferline").go_to_buffer(8, true)
      end,
      "Buffer 8",
    },
    ["<leader>9"] = {
      function()
        require("bufferline").go_to_buffer(9, true)
      end,
      "Buffer 9",
    },
  },
}

M.nvimtree = {
  ["n"] = {
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle tree" },
  },
}

M.toggleterm = {
  ["t"] = {
    ["<C-x>"] = {
      vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
      "Close terminal",
    },
  },
}

M.dap = {
  ["n"] = {
    ["<F5>"] = {
      function()
        require("dap").continue()
      end,
      "DAP continue",
    },
    ["<F10>"] = {
      function()
        require("dap").step_over()
      end,
      "DAP step over",
    },
    ["<F11>"] = {
      function()
        require("dap").step_into()
      end,
      "DAP step into",
    },
    ["<F12>"] = {
      function()
        require("dap").step_out()
      end,
      "DAP step out",
    },
    ["<leader>B"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "DAP toggle breakpoint",
    },
  },
}

return M
