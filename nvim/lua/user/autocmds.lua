-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd "tabdo wincmd ="
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- need to find a way to override for lazy
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "AlphaReady",
--     desc = "hide cursor for alpha",
--     callback = function()
--         local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
--         hl.blend = 100
--         vim.api.nvim_set_hl(0, "Cursor", hl)
--         vim.opt.guicursor:append "a:Cursor/lCursor"
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("BufUnload", {
--     buffer = 0,
--     desc = "show cursor after alpha",
--     callback = function()
--         local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
--         hl.blend = 0
--         vim.api.nvim_set_hl(0, "Cursor", hl)
--         vim.opt.guicursor:remove "a:Cursor/lCursor"
--     end,
-- })