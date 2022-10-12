local M = {}

M.general = {
  ["i"] = {
    -- to quit insert mode fast
    ["jk"] = "<ESC>",
    ["kj"] = "<ESC>",
    ["jj"] = "<ESC>",
    -- go to beginning of line
    ["<C-b>"] = "<ESC>^i",
    -- go to end of line
    ["<C-e>"] = "<End>",
    -- navigate within insert mode
    ["<C-h>"] = "<Left>",
    ["<C-l>"] = "<Right>",
    ["<C-k>"] = "<Up>",
    ["<C-j>"] = "<Down>",
    -- Move current line / block
    ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
  },
  ["n"] = {
    -- remove highlight
    ["<ESC>"] = "<cmd> noh <CR>",
    -- Resize with arrows
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",
    -- switch between windows
    ["<C-h>"] = "<C-w>h",
    ["<C-l>"] = "<C-w>l",
    ["<C-k>"] = "<C-w>k",
    ["<C-j>"] = "<C-w>j",
    -- save file
    ["<C-s>"] = "<cmd> w <CR>",
    -- line numbers
    ["<leader>n"] = "<cmd> set nu! <CR>",
    ["<leader>nn"] = "<cmd> set rnu! <CR>",
    -- Move current line / block
    ["<A-j>"] = ":m .+1<CR>==",
    ["<A-k>"] = ":m .-2<CR>==",
  },
  ["v"] = {
    -- indenting
    ["<"] = "<gv",
    [">"] = ">gv",
  },
  ["x"] = {
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = ":m '>+1<CR>gv-gv",
    ["<A-k>"] = ":m '<-2<CR>gv-gv",
  },
  ["t"] = {},
}

M.comment = {
  ["n"] = {
    ["<leader>/"] = function()
      require("Comment.api").toggle.linewise.current()
    end,
  },

  ["v"] = {
    ["<leader>/"] = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  },
}

M.lspconfig = {
  ["n"] = {
    ["gD"] = function()
      vim.lsp.buf.declaration()
    end,

    -- ["gd"] = function()
    --   vim.lsp.buf.definition()
    -- end,

    ["K"] = function()
      vim.lsp.buf.hover()
    end,

    -- ["gi"] = function()
    --   vim.lsp.buf.implementation()
    -- end,

    ["<leader>ls"] = function()
      vim.lsp.buf.signature_help()
    end,

    -- ["<leader>D"] = function()
    --   vim.lsp.buf.type_definition()
    -- end,

    ["<leader>ca"] = function()
      vim.lsp.buf.code_action()
    end,

    -- ["gr"] = function()
    --   vim.lsp.buf.references()
    -- end,

    ["<leader>f"] = function()
      vim.diagnostic.open_float()
    end,

    -- ["<leader>rn"] = function()
    --   vim.lsp.buf.rename()
    -- end,

    ["[d"] = function()
      vim.diagnostic.goto_prev()
    end,

    ["d]"] = function()
      vim.diagnostic.goto_next()
    end,

    ["<leader>q"] = function()
      vim.diagnostic.setloclist()
    end,

    ["<leader>fm"] = function()
      vim.lsp.buf.format { async = true }
    end,

    ["<leader>wa"] = function()
      vim.lsp.buf.add_workspace_folder()
    end,

    ["<leader>wr"] = function()
      vim.lsp.buf.remove_workspace_folder()
    end,

    ["<leader>wl"] = function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
  },
}

M.telescope = {
  ["n"] = {
    ["<leader>ff"] = "<cmd> Telescope find_files <CR>",
    ["<leader>fa"] = "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
    ["<leader>fw"] = "<cmd> Telescope live_grep <CR>",
    ["<leader>fb"] = "<cmd> Telescope buffers <CR>",
    ["<leader>fh"] = "<cmd> Telescope help_tags <CR>",
    ["<leader>fo"] = "<cmd> Telescope oldfiles <CR>",
    ["<leader>tk"] = "<cmd> Telescope keymaps <CR>",
    ["<leader>cm"] = "<cmd> Telescope git_commits <CR>",
    ["<leader>gt"] = "<cmd> Telescope git_status <CR>",
  },
}

M.hop = {
  ["n"] = {
    ["<leader>t"] = "<cmd> HopWord <CR>",
    ["<leader>T"] = "<cmd> HopLine <CR>",
  },
}

M.gitsigns = {
  ["n"] = {
    ["<leader>gs"] = "<cmd> Gitsigns toggle_signs <CR>",
    ["<leader>gn"] = "<cmd> Gitsigns toggle_numhl<CR>",
    ["<leader>gl"] = "<cmd> Gitsigns toggle_linehl<CR>",
    ["<leader>gw"] = "<cmd> Gitsigns toggle_word_diff <CR>",
  },
}

M.trouble = {
  ["n"] = {
    ["<leader>xx"] = "<cmd> TroubleToggle <CR>",
    ["<leader>xw"] = "<cmd> TroubleToggle workspace_diagnostics <CR>",
    ["<leader>xd"] = "<cmd> TroubleToggle document_diagnostics <CR>",
    ["<leader>xl"] = "<cmd> TroubleToggle loclist <CR>",
    ["<leader>xq"] = "<cmd> TroubleToggle quickfix <CR>",
    ["gr"] = "<cmd> TroubleToggle lsp_references <CR>",
    ["gi"] = "<cmd> TroubleToggle lsp_implementations <CR>",
    ["gd"] = "<cmd> TroubleToggle lsp_definitions <CR>",
    ["D"] = "<cmd> TroubleToggle lsp_type_definitions <CR>",
  },
}

M.rename = {
  ["n"] = {
    ["<leader>rn"] = {
      function()
        return ":IncRename " .. vim.fn.expand "<cword>"
      end,
      { expr = true },
    },
  },
}

M.bufferline = {
  ["n"] = {
    ["<leader>bd"] = "<cmd> BufferKill <CR>",
    ["<leader>]"] = "<cmd> BufferLineCycleNext<CR>",
    ["<leader>["] = "<cmd> BufferLineCyclePrev<CR>",
    ["<leader>m]"] = "<cmd> BufferLineMoveNext<CR>",
    ["<leader>m["] = "<cmd> BufferLineMovePrev<CR>",
    ["<leader>1"] = function()
      require("bufferline").go_to_buffer(1, true)
    end,
    ["<leader>2"] = function()
      require("bufferline").go_to_buffer(2, true)
    end,
    ["<leader>3"] = function()
      require("bufferline").go_to_buffer(3, true)
    end,
    ["<leader>4"] = function()
      require("bufferline").go_to_buffer(4, true)
    end,
    ["<leader>5"] = function()
      require("bufferline").go_to_buffer(5, true)
    end,
    ["<leader>6"] = function()
      require("bufferline").go_to_buffer(6, true)
    end,
    ["<leader>7"] = function()
      require("bufferline").go_to_buffer(7, true)
    end,
    ["<leader>8"] = function()
      require("bufferline").go_to_buffer(8, true)
    end,
    ["<leader>9"] = function()
      require("bufferline").go_to_buffer(9, true)
    end,
  },
}

M.nvimtree = {
  ["n"] = {
    -- toggle
    ["<C-n>"] = "<cmd> NvimTreeToggle <CR>",
  },
}

M.toggleterm = {
  ["t"] = {
    ["<C-x>"] = vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
  },
}

return M
