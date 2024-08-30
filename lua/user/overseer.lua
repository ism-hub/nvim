require('overseer').setup({
    templates = { "builtin", "user.debug_dotnet_test", "user.run_dotnet_test", "user.dotnet_build" },
    strategy = {
        "toggleterm",
        close_on_exit = false,
        quit_on_exit = 'never',
        hidden = false,
        -- open_on_start = false,
        -- use_shell = true,
        -- direction = 'tab',
        on_create = function(term)
            -- Switch to normal mode after the terminal is created
            vim.cmd("stopinsert")
        end
    },
    task_list = {
        bindings = {
            ["<C-h>"] = false,
        },
    },
})

-- loading bunch of user tasks
-- the tasks should be under <proj_root(.git)>/../tasks/my_tasks.lua
local root_patterns = { ".git" }
local before_root_dir = vim.fs.dirname(vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1]))
if before_root_dir == nil then
    return
end

package.path = package.path .. before_root_dir .. "/tasks/?.lua" .. ";"

-- local dotnet_run_task = require('overseer.template.user.dotnet_run')
-- local dotnet_debug_task = require('overseer.template.user.dotnet_debug')
-- local run_myconsole_proj = require('overseer').wrap_template(dotnet_run_task, { name = "Run My-Console-App" },
--     { project = "MyApp.Console", env = { MY_ENV_VAR = "env from wrapped" } })
-- local debug_myconsole_proj = require('overseer').wrap_template(dotnet_debug_task, { name = "Debug My-Console-App" },
--     { project = "MyApp.Console", env = { MY_ENV_VAR = "env from wrapped for debug" } })
-- require('overseer').register_template(run_myconsole_proj)
-- require('overseer').register_template(debug_myconsole_proj)

local ok, tasks = pcall(require, "my_tasks")
if ok then
    for i, task in ipairs(tasks) do
        require('overseer').register_template(task)
    end
end

-- code actions for run/debug specific dotnet test
local null_ls = require("null-ls")
null_ls.register({
    name = "dotnet test",
    method = null_ls.methods.CODE_ACTION,
    filetypes = { "cs" },
    generator = {
        fn = function(params)
            local node = vim.treesitter.get_node()
            local parent = node:parent()

            if parent == nil then
                return {}
            end

            local parent_type = parent:type() -- method_declaration

            if parent_type ~= "method_declaration" then
                return {}
            end

            local saw_fact_attr = false
            for child in parent:iter_children() do
                local type = child:type()
                if type == "attribute_list" then
                    local attr_text = vim.treesitter.get_node_text(child, params["bufnr"])
                    if not string.match(attr_text, "Fact") then
                        return {}
                    else
                        saw_fact_attr = true
                    end
                elseif type == 'identifier' then
                    if not saw_fact_attr then
                        return {}
                    end
                    local func_name = vim.treesitter.get_node_text(child, params["bufnr"])
                    if func_name:lower():match("^test") then
                        return {
                            {
                                title = 'debug',
                                action = function()
                                    require('overseer').run_template({ name = "DebugDotnetTest", params = { test_name = func_name } })
                                end
                            },
                            {
                                title = 'run',
                                action = function()
                                    require('overseer').run_template({ name = "RunDotnetTest", params = { test_name = func_name } })
                                end
                            }
                        }
                    else
                        return {}
                    end
                end
            end
        end
    }
})
