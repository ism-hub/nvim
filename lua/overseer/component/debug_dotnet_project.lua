return {
    desc = "starts dotnet debug session on specific project",
    -- Define parameters that can be passed in to the component
    params = {
        -- See :help overseer-params
        project = { type = "string" },
        env = { type = "opaque" },
    },
    -- Optional, default true. Set to false to disallow editing this component in the task editor
    editable = true,
    -- Optional, default true. When false, don't serialize this component when saving a task to disk
    serializable = true,
    -- The params passed in will match the params defined above
    constructor = function(params)
        -- You may optionally define any of the methods below
        local once = false
        return {
            ---@param status overseer.Status Can be CANCELED, FAILURE, or SUCCESS
            ---@param result table A result table.
            on_complete = function(self, task, status, result)
                if status == 'SUCCESS' then
                    require("dap").run(
                        {
                            type = "coreclr",
                            name = "launch - netcoredbg",
                            request = "launch",
                            program = vim.fn.getcwd() ..
                                '/' .. params['project'] .. '/bin/Debug/net8.0/' .. params['project'] .. '.dll',
                            env = params['env'],
                        })
                end
                -- Called when the task has reached a completed state.
            end,
        }
    end,
    condition = {
        -- A string or list of strings
        -- Only matches when current buffer is one of the listed filetypes
        filetype = { "cs" },
    },
}
