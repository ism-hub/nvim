return {
    desc = "Reads the output finds the process-id and executes the dap attach",
    -- Define parameters that can be passed in to the component
    params = {
        -- See :help overseer-params
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
            ---@param lines string[] Completed lines of output, with ansi codes removed.
            on_output_lines = function(self, task, lines)
                for i, line in ipairs(lines) do
                    local pid = string.match(line, "Process Id: (%d+), Name")
                    if not once and pid ~= nil then
                        once = true
                        require("dap").run({
                            type = "coreclr",
                            name = "attach",
                            request = "attach",
                            processId = tonumber(pid),
                        })
                    end
                end
            end,
        }
    end,
    condition = {
        -- A string or list of strings
        -- Only matches when current buffer is one of the listed filetypes
        filetype = { "cs" },
    },
}
