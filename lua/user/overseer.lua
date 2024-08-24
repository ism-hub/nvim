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
