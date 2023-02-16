return {
    {
        "mfussenegger/nvim-dap",
        event = "BufReadPre",
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
            { "theHamsta/nvim-dap-virtual-text" },
            { "mfussenegger/nvim-dap-python" },
        },
        init = function()
            require("user.utils").load_keymap "dap"
        end,
        config = function(_, opts)
            local dap = require "dap"
            local dapui = require "dapui"

            require("nvim-dap-virtual-text").setup { commented = true }
            require("dapui").setup()

            dapui.setup()

            -- dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            -- dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            -- dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

            require("dap-python").setup("python", {})

            dap.adapters.codelldb = {
                name = "codelldb server",
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
            }
        end,
    },
}
