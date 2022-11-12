local M = {}

local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 42,
    align_shortcut = "right",
    hl = "AlphaButtons",
  }

  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local fn = vim.fn
local marginTopPercent = 0.15
local headerPadding = fn.max { 5, fn.floor(fn.winheight(0) * marginTopPercent) }

local function footer()
  local date = os.date "  %d/%m/%Y "
  local time = os.date "  %H:%M:%S "
  local plugins = "  " .. #vim.tbl_keys(packer_plugins) .. " plugins "

  local v = vim.version()
  local version = "  v" .. v.major .. "." .. v.minor .. "." .. v.patch

  return date .. time .. plugins .. version
end

local options = {
  header = {
    type = "text",
    val = {
      "                                         _.oo.",
      "                 _.u[[/;:,.         .odMMMMMM'",
      "              .o888UU[[[/;:-.  .o@P^    MMM^",
      "             oN88888UU[[[/;::-.        dP^",
      "            dNMMNN888UU[[[/;:--.   .o@P^",
      "           ,MMMMMMN888UU[[/;::-. o@^",
      "           NNMMMNN888UU[[[/~.o@P^",
      "           888888888UU[[[/o@^-..",
      "          oI8888UU[[[/o@P^:--..",
      "       .@^  YUU[[[/o@^;::---..",
      "     oMP     ^/o@P^;:::---..",
      "  .dMMM    .o@^ ^;::---...",
      " dMMMMMMM@^`       `^^^^",
      "YMMMUP^",
      " ^^",
    },
    opts = {
      position = "center",
      hl = "AlphaHeader",
    },
  },
  buttons = {
    type = "group",
    val = {
      button("SPC s l", "  Load last session", ":SessionLoadLast<CR>"),
      button("SPC s s", "  Select sessions", ":Telescope persisted<CR>"),
      button("SPC f f", "  Find File", ":Telescope find_files<CR>"),
      button("SPC f w", "  Find Word", ":Telescope live_grep<CR>"),
      button("SPC f o", "  Recent File", ":Telescope oldfiles<CR>"),
      button("SPC f p", "  Recent Projects", ":Telescope projects<CR>"),
      button("SPC f u", "  Update plugins", ":PackerSync<CR>"),
      button("SPC e s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
      button("SPC q q", "  Quit", ":qa<CR>"),
    },
    opts = {
      spacing = 1,
    },
  },
  footer = {
    type = "text",
    val = footer(),
    opts = {
      position = "center",
      hl = "Constant",
    },
  },
}

function M.setup()
  local present, alpha = pcall(require, "alpha")

  if not present then
    return
  end

  alpha.setup {
    layout = {
      { type = "padding", val = headerPadding },
      options.header,
      { type = "padding", val = 2 },
      options.buttons,
      { type = "padding", val = 1 },
      options.footer,
    },
    opts = {
      setup = function()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          desc = "hide cursor for alpha",
          callback = function()
            local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
            hl.blend = 100
            vim.api.nvim_set_hl(0, "Cursor", hl)
            vim.opt.guicursor:append "a:Cursor/lCursor"
          end,
        })
        vim.api.nvim_create_autocmd("BufUnload", {
          buffer = 0,
          desc = "show cursor after alpha",
          callback = function()
            local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
            hl.blend = 0
            vim.api.nvim_set_hl(0, "Cursor", hl)
            vim.opt.guicursor:remove "a:Cursor/lCursor"
          end,
        })
      end,
    },
  }
end

return M
