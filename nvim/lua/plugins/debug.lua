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

            local mason_path = vim.fn.stdpath "data" .. "/mason"
            local codelldb_path = mason_path .. "/bin/codelldb"
            local liblldb_path = mason_path .. "/packages/codelldb/extension/lldb/lib/liblldb.so"
            local debugpy_path = mason_path .. "/bin/debugpy"

            require("nvim-dap-virtual-text").setup { commented = true }

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            -- dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            -- dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

            dap.adapters.codelldb = {
                name = "codelldb server",
                type = "server",
                host = "127.0.0.1",
                port = "${port}",
                executable = {
                    command = codelldb_path,
                    args = { "--liblldb", liblldb_path, "--port", "${port}" },
                },
            }

            dap.configurations.cpp = {
                {
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    --program = '${fileDirname}/${fileBasenameNoExtension}',
                    cwd = "${workspaceFolder}",
                    terminal = "integrated",
                },
            }

            require("dap-python").setup(debugpy_path)
        end,
    },
}
