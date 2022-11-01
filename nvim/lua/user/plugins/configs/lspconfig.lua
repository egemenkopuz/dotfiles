local M = {}

function M.on_attach(client, bufnr)
  local sc = client.server_capabilities

  sc.documentFormattingProvider = false
  sc.documentRangeFormattingProvider = false

  require("user.utils").keys.load_section("lspconfig", { buffer = bufnr })
  require("lsp_signature").on_attach({ bind = true }, bufnr)
end

local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

function M.setup()
  local present, lspconfig = pcall(require, "lspconfig")

  if not present then
    return
  end

  lspconfig.sumneko_lua.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  }

  lspconfig.rust_analyzer.setup {
    flags = flags,
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
        },
        procMacro = {
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
      },
    },
  }

  lspconfig.pyright.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
      python = {
        analysis = {
          -- typeCheckingMode = "off",
        },
      },
    },
  }

  -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  -- for type, icon in pairs(signs) do
  --   local hl = "DiagnosticSign" .. type
  --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  -- end
end

return M
