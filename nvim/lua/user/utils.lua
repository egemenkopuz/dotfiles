local M = { keys = {}, lazy = {} }

local merge_tb = vim.tbl_deep_extend
local autocmd = vim.api.nvim_create_autocmd
local general_opts = { noremap = true, silent = true }
local term_opts = { silent = true }

function M.keys.load(keys, additional_opts)
  local wk_present, wk = pcall(require, "which-key")
  local mapping_func
  if wk_present then
    mapping_func = function(mode, keybind, val, opts)
      opts.mode = mode
      wk.register({ [keybind] = val }, opts)
    end
  else
    mapping_func = function(mode, keybind, val, opts)
      vim.keymap.set(mode, keybind, val[1], opts)
    end
  end
  for mode, mapping in pairs(keys) do
    local opts
    if mode == "t" then
      opts = term_opts
    else
      opts = general_opts
    end
    opts = merge_tb("force", opts, additional_opts or {})
    for key, val in pairs(mapping) do
      opts = merge_tb("force", opts, val.opts or {})
      if val.opts then
        val.opts = nil
      end
      -- if #val == 1 then
      --   print(mode)
      --   vim.keymap.set(mode, key, val[1], opts)
      -- end
      mapping_func(mode, key, val, opts)
    end
  end
end

function M.keys.load_section(section_name, additional_opts)
  additional_opts = additional_opts or nil
  local present, keys = pcall(require, "user.keys")
  if not present or keys[section_name] == nil then
    return
  end
  M.keys.load(keys[section_name], additional_opts)
end

function M.lazy.load(tb)
  autocmd(tb.events, {
    pattern = "*",
    group = vim.api.nvim_create_augroup(tb.augroup_name, {}),
    callback = function()
      if tb.condition() then
        vim.api.nvim_del_augroup_by_name(tb.augroup_name)
        if tb.plugins ~= "nvim-treesitter" then
          vim.defer_fn(function()
            vim.cmd("PackerLoad " .. tb.plugins)
          end, 0)
        else
          vim.cmd("PackerLoad " .. tb.plugins)
        end
      end
    end,
  })
end

function M.lazy.on_file_open(plugin_name)
  M.lazy.load {
    events = { "BufRead", "BufWinEnter", "BufNewFile" },
    augroup_name = "BeLazyOnFileOpen" .. plugin_name,
    plugins = plugin_name,
    condition = function()
      local file = vim.fn.expand "%"
      return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
    end,
  }
end

return M
