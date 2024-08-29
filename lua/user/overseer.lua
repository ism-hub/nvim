require('overseer').setup({
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

local tasks = require "my_tasks"
for i, task in ipairs(tasks) do
    require('overseer').register_template(task)
end
