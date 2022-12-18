local M = {}

M.general = {
  ["i"] = {
    -- to quit insert mode fast
    ["jk"] = { "<ESC>", "leave insert mode" },
    ["kj"] = { "<ESC>", "leave insert mode" },
    ["jj"] = { "<ESC>", "leave insert mode" },
    -- go to beginning of line
    ["<C-b>"] = { "<ESC>^i", "go to beginning of line" },
    -- go to end of line
    ["<C-e>"] = { "<End>", "go to end of line" },
    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "navigate left" },
    ["<C-l>"] = { "<Right>", "navigate right" },
    ["<C-k>"] = { "<Up>", "navigate up" },
    ["<C-j>"] = { "<Down>", "navigate down" },
    -- Move current line / block
    ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", "move current line/block down" },
    ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", "move current line/block up" },
  },
  ["n"] = {
    -- remove highlight
    ["<ESC>"] = { "<cmd> noh <CR>", "remove highlight" },
    -- Resize with arrows
    ["<C-Up>"] = { ":resize -2<CR>", "resize window up" },
    ["<C-Down>"] = { ":resize +2<CR>", "resize window down" },
    ["<C-Left>"] = { ":vertical resize -2<CR>", "resize window left" },
    ["<C-Right>"] = { ":vertical resize +2<CR>", "resize window right" },
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "switch to left window" },
    ["<C-l>"] = { "<C-w>l", "switch to right window" },
    ["<C-k>"] = { "<C-w>k", "switch to upper window" },
    ["<C-j>"] = { "<C-w>j", "switch to lower window" },
    -- save file
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line numbers" },
    ["<leader>nn"] = { "<cmd> set rnu! <CR>", "toggle relative line numbers" },
    -- Move current line / block
    ["<A-j>"] = { ":m .+1<CR>==", "move current line/block down" },
    ["<A-k>"] = { ":m .-2<CR>==", "move current line/block up" },
    -- select all
    ["<C-a>"] = { "gg<S-v>G", "select all" },
  },
  ["v"] = {
    -- indenting
    ["<"] = { "<gv", "indent left" },
    [">"] = { ">gv", "indent right" },
    ["<leader>s"] = { ":sort<CR>", "sort ascending" },
    ["<leader>S"] = { ":sort!<CR>", "sort descending" },
  },
  ["x"] = {
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = { ":m '>+1<CR>gv-gv", "move current line/block down" },
    ["<A-k>"] = { ":m '<-2<CR>gv-gv", "move current line/block up" },
  },
  ["t"] = {},
}

M.comment = {
  ["n"] = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "comment out",
    },
  },

  ["v"] = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
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
    -- ["<leader>f"] = {
    --   function()
    --     vim.diagnostic.open_float()
    --   end,
    --   "LSP Open Float",
    -- },
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
      "find files",
    },
    ["<leader>fa"] = {
      "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
      "find file global",
    },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help tags" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "old files" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "key maps" },
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commit" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },
    ["<leader>dl"] = { "<cmd> Telescope diagnostics <CR>", "diagnostics" },
  },
}

M.hop = {
  ["n"] = {
    -- ["<leader>k"] = { "<cmd>HopLineBC<CR>", "hop line up" },
    -- ["<leader>j"] = { "<cmd>HopLineAC<CR>", "hop line down" },
    -- ["<leader><leader>k"] = { "<cmd>HopWordBC<CR>", "hop word up" },
    -- ["<leader><leader>j"] = { "<cmd>HopWordAC<CR>", "hop word down" },
    ["<leader>k"] = { "<cmd>HopWordBC<CR>", "hop word up" },
    ["<leader>j"] = { "<cmd>HopWordAC<CR>", "hop word down" },
  },
}

M.gitsigns = {
  ["n"] = {
    ["<leader>gs"] = { "<cmd> Gitsigns toggle_signs <CR>", "toggle git signs" },
    ["<leader>gn"] = { "<cmd> Gitsigns toggle_numhl<CR>", "toggle git numhl" },
    ["<leader>gl"] = { "<cmd> Gitsigns toggle_linehl<CR>", "toggle git linehl" },
    ["<leader>gw"] = {
      "<cmd> Gitsigns toggle_word_diff <CR>",
      "toggle git diff",
    },
  },
}

M.trouble = {
  ["n"] = {
    ["<leader>xx"] = { "<cmd> TroubleToggle <CR>", "toggle trouble" },
    ["<leader>xw"] = {
      "<cmd> TroubleToggle workspace_diagnostics <CR>",
      "workspace diagnostics",
    },
    ["<leader>xd"] = {
      "<cmd> TroubleToggle document_diagnostics <CR>",
      "document diagnostics",
    },
    ["<leader>xl"] = { "<cmd> TroubleToggle loclist <CR>", "loclist" },
    ["<leader>xq"] = { "<cmd> TroubleToggle quickfix <CR>", "quickfix" },
    -- ["gr"] = { "<cmd> TroubleToggle lsp_references <CR>", "LSP references" },
    -- ["gi"] = {
    --   "<cmd> TroubleToggle lsp_implementations <CR>",
    --   "LSP implementations",
    -- },
    -- ["gd"] = { "<cmd> TroubleToggle lsp_definitions <CR>", "LSP definitions" },
    -- ["D"] = {
    --   "<cmd> TroubleToggle lsp_type_definitions <CR>",
    --   "LSP type definitions",
    -- },
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
    ["<leader>bd"] = { "<cmd> BufferKill <CR>", "buffer kill" },
    ["<leader>]"] = { "<cmd> BufferLineCycleNext<CR>", "cycle buffer next" },
    ["<leader>["] = { "<cmd> BufferLineCyclePrev<CR>", "cycle buffer prev" },
    ["<leader>m]"] = { "<cmd> BufferLineMoveNext<CR>", "move buffer next" },
    ["<leader>m["] = { "<cmd> BufferLineMovePrev<CR>", "move buffer left" },
    ["<leader>1"] = {
      function()
        require("bufferline").go_to_buffer(1, true)
      end,
      "buffer 1",
    },
    ["<leader>2"] = {
      function()
        require("bufferline").go_to_buffer(2, true)
      end,
      "buffer 2",
    },
    ["<leader>3"] = {
      function()
        require("bufferline").go_to_buffer(3, true)
      end,
      "buffer 3",
    },
    ["<leader>4"] = {
      function()
        require("bufferline").go_to_buffer(4, true)
      end,
      "buffer 4",
    },
    ["<leader>5"] = {
      function()
        require("bufferline").go_to_buffer(5, true)
      end,
      "buffer 5",
    },
    ["<leader>6"] = {
      function()
        require("bufferline").go_to_buffer(6, true)
      end,
      "buffer 6",
    },
    ["<leader>7"] = {
      function()
        require("bufferline").go_to_buffer(7, true)
      end,
      "buffer 7",
    },
    ["<leader>8"] = {
      function()
        require("bufferline").go_to_buffer(8, true)
      end,
      "buffer 8",
    },
    ["<leader>9"] = {
      function()
        require("bufferline").go_to_buffer(9, true)
      end,
      "buffer 9",
    },
  },
}

M.nvimtree = {
  ["n"] = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle tree" },
  },
}

M.truezen = {
  ["n"] = {
    ["<leader>zn"] = { "<cmd> TZAtaraxis<CR>", "toggle zen mode" },
  },
}

M.toggleterm = {
  ["t"] = {
    ["<C-x>"] = {
      vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
      "close terminal",
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
    -- ["<leader>B"] = {
    --   function()
    --     require("dap").set_breakpoint()
    --   end,
    --   "DAP set breakpoint",
    -- },
  },
}

return M
