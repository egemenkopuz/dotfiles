local M = {}

local autocmd = vim.api.nvim_create_autocmd

local options = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "│" },
    topdelete = { text = "│" },
    changedelete = { text = "│" },
  },
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
  },
  on_attach = function(bufnr)
    require("user.utils").keys.load_section("gitsigns", { buffer = bufnr })
  end,
}

function M.lazy_laod()
  autocmd({ "BufRead" }, {
    group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
    callback = function()
      vim.fn.system("git rev-parse " .. vim.fn.expand "%:p:h")
      if vim.v.shell_error == 0 then
        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
        vim.schedule(function()
          require("packer").loader "gitsigns.nvim"
        end)
      end
    end,
  })
end

function M.setup()
  local present, gitsigns = pcall(require, "gitsigns")

  if not present then
    return
  end

  gitsigns.setup(options)
end

return M
