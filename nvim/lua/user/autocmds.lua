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
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 50 }
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        vim.cmd "tabdo wincmd ="
    end,
})

vim.api.nvim_create_autocmd({ "BufAdd", "TabEnter" }, {
    pattern = "*",
    callback = function()
        local count = #vim.fn.getbufinfo { buflisted = 1 }
        local status = count > 1 and 2 or 0
        if vim.o.showtabline ~= status then
            vim.o.showtabline = status
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufDelete" }, {
    pattern = "*",
    callback = function()
        local count = #vim.fn.getbufinfo { buflisted = 1 } - 1
        local status = count > 1 and 2 or 0
        if vim.o.showtabline ~= status then
            vim.o.showtabline = status
        end
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
