local wk = require("which-key")
-- debugging (dap)
wk.register({
    ["<leader>d"] = { name = "+debug" },
    ["<leader>dc"] = {
        function()
            require("dap").continue()
        end,
        "Continue",
    },
    ["<leader>dn"] = {
        function()
            require("dap").step_over()
        end,
        "Step Over",
    },
    ["<leader>di"] = {
        function()
            require("dap").step_into()
        end,
        "Step Into",
    },
    ["<leader>do"] = {
        function()
            require("dap").step_out()
        end,
        "Step Out",
    },
    ["<leader>db"] = {
        function()
            require("dap").toggle_breakpoint()
        end,
        "Breakpoint",
    },
    ["<leader>dL"] = {
        function()
            require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        "Breakpoint With Msg",
    },
    ["<leader>dr"] = {
        function()
            require("dap").repl.open()
        end,
        "REPL",
    },
    ["<leader>dl"] = {
        function()
            require("dap").run_last()
        end,
        "Run Last",
    },
    ["<leader>dh"] = {
        function()
            require("dap.ui.widgets").hover()
        end,
        "Hover",
    },
    ["<leader>dp"] = {
        function()
            require("dap.ui.widgets").preview()
        end,
        "Preview",
    },
    ["<leader>df"] = {
        function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end,
        "Frames",
    },
    ["<leader>ds"] = {
        function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
        end,
        "Scopes",
    },
}, opts)
