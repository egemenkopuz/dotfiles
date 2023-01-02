local M = {}

function M.setup()
  local present, null_ls = pcall(require, "null-ls")

  if not present then
    return
  end

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local options = {
    sources = {
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.trim_whitespace,
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.diagnostics.pydocstyle.with {
        extra_args = { "--config=$ROOT/setup.cfg" },
      },
      -- null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.formatting.clang_format,
    },
    debug = false,
    on_attach = function(client, bufnr)
      if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format { bufnr = bufnr }
          end,
        })
      end
    end,
  }

  null_ls.setup(options)
end

return M
