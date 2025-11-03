local dap = require('dap')

dap.adapters.coreclr = {
    type = 'executable',
    command = vim.env.HOME .. '/.local/share/nvim/mason/bin/netcoredbg',
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    },
    {
        type = "coreclr",
        name = "attach",
        request = "attach",
        processId = require('dap.utils').pick_process,
    },
}

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        -- Change this to your path!
        command = vim.env.HOME .. '/.local/share/nvim/mason/bin/codelldb',
        args = { "--port", "${port}" },
    }
}

dap.configurations.rust = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            local all = vim.fn.glob(vim.fn.getcwd() .. '/target/debug/**/*', true, true)

            local bins = vim.tbl_filter(function(p)
                if vim.fn.isdirectory(p) == 1 then return false end -- no dirs
                -- executable bit set for user/group/other
                return vim.fn.executable(p) == 1 or (vim.fn.getfperm(p):find("x") ~= nil)
            end, all)

            -- optional: prefer top-level over deps/
            local top = vim.tbl_filter(function(p) return not p:find("/deps/") end, bins)

            local candidates = (#top > 0) and top or bins
            if #candidates == 1 then return candidates[1] end

            -- pick from our list (DAP calls this in a coroutine, so yield/resume works)
            local co = coroutine.running()
            vim.ui.select(
                candidates,
                { prompt = "Select executable", format_item = function(p) return vim.fn.fnamemodify(p, ":.") end },
                function(choice) coroutine.resume(co, choice) end
            )
            return coroutine.yield()
            -- print(vim.inspect(candidates))
            -- if #candidates == 1 then return candidates[1] end
            -- return require('dap.utils').pick_file(bins)
        end,
        -- program = function()
        --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        -- end,
        -- cwd = '${workspaceFolder}',
        stopOnEntry = false
    },
}
