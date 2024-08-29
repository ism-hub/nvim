return
{
    -- Required fields
    name = "DotnetBuild",
    builder = function(params)
        -- This must return an overseer.TaskDefinition
        return {
            -- cmd is the only required field
            cmd = { "dotnet" },
            -- additional arguments for the cmd
            args = { 'build', '-c', 'Debug' },
            -- the name of the task (defaults to the cmd of the task)
            -- name = "DotnetBuild",
            -- set the working directory for the task
            cwd = ".",
            -- additional environment variables
            env = {
                -- VSTEST_HOST_DEBUG = "1",
            },
            -- the list of components or component aliases to add to the task
            -- components = { "attach_debuger_on_dotnet_test", "on_exit_set_status" },
            -- arbitrary table of data for your own personal use
            -- metadata = {
            --     foo = "bar",
            -- },
        }
    end,
    condition = {
        filetype = { "cs" },
    },
    -- Optional fields
    -- desc = "Lim.Console",
}
