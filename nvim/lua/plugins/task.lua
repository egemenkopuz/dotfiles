return {
    "stevearc/overseer.nvim",
    event = "BufReadPre",
    opts = {},
    config = function()
        require("overseer").setup()
    end,
}
