return
{
    params = {
        project = { type = 'string' },
        env = { type = 'opaque' },
        cwd = { type = "string" },
        program = { type = "string" },
    },
    -- Required fields
    name = "DotnetDebug",
    builder = function(params)
        -- This must return an overseer.TaskDefinition
        return {
            -- cmd is the only required field
            cmd = { "dotnet" },
            -- additional arguments for the cmd
            args = { 'build', params["project"], '-c', 'Debug' },
            -- the name of the task (defaults to the cmd of the task)
            -- name = "DotnetBuild",
            -- set the working directory for the task
            cwd = params['cwd'],
            -- additional environment variables
            -- env = {
            -- VSTEST_HOST_DEBUG = "1",
            -- },
            -- the list of components or component aliases to add to the task
            components = { { "debug_dotnet_project", program = params['program'], cwd = params['cwd'], project = params["project"], env = params["env"] }, "on_exit_set_status" },
            -- arbitrary table of data for your own personal use
            -- metadata = {
            --     foo = "bar",
            -- },
        }
    end,
    condition = {
        callback = function(search)
            -- check if sln or csproj exists
            return vim.fn.glob('*.sln') ~= '' or
                vim.fn.glob('*/*.sln') ~= '' or
                vim.fn.glob('*.csproj') ~= '' or
                vim.fn.glob('*/*.csproj') ~= ''
        end,
    },
    -- Optional fields
    -- desc = "Console",
}
