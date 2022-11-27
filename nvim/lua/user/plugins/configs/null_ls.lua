local M = {}

local async_formatting = function(client, bufnr)
  -- if client.supports_method "textDocument/formatting" then
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     group = vim.api.nvim_create_augroup("FORMATTING", { clear = true }),
  --     buffer = bufnr,
  --     callback = function()
  --       vim.lsp.buf.format {
  --         timeout_ms = 3000,
  --         buffer = bufnr,
  --       }
  --     end,
  --   })
  -- end
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(
    bufnr,
    "textDocument/formatting",
    { textDocument = { uri = vim.uri_from_bufnr(bufnr) } },
    function(err, res, ctx)
      if err then
        local err_msg = type(err) == "string" and err or err.message
        -- you can modify the log message / level (or ignore it completely)
        -- vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
        return
      end

      -- don't apply results if buffer is unloaded or has been modified
      if
        not vim.api.nvim_buf_is_loaded(bufnr)
        or vim.api.nvim_buf_get_option(bufnr, "modified")
      then
        return
      end

      if res then
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd "silent noautocmd update"
        end)
      end
    end
  )
end

function M.setup()
  local present, null_ls = pcall(require, "null-ls")

  if not present then
    return
  end

  local options = {
    sources = {
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.trim_whitespace,
      null_ls.builtins.diagnostics.flake8,
      -- null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.diagnostics.pydocstyle.with {
        extra_args = { "--config=$ROOT/setup.cfg" },
      },
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.rustfmt,
      -- null_ls.builtins.code_actions.refactoring,
    },
    debug = true,
    on_attach = function(client, bufnr)
      if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePost", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            async_formatting(client, bufnr)
          end,
        })
      end
    end,
  }

  null_ls.setup(options)
end

return M
