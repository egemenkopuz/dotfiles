return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                init = function()
                    require("user.utils").load_keymap "dapui"
                end,
                config = function(_, opts)
                    require("dapui").setup { opts }
                end,
            },
        },
        init = function()
            require("user.utils").load_keymap "dap"
        end,
        config = function(_, opts)
            local dap = require "dap"
            dap.adapters.python = {
                type = "executable",
                command = "path/to/virtualenvs/debugpy/bin/python",
                args = { "-m", "debugpy.adapter" },
            }
        end,
    },
}
