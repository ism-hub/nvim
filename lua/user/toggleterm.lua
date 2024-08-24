require("toggleterm").setup({
    --     enabled = true,
    winbar = {
        enabled = true,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end
    },
    close_on_exit = false,
})

-- term 1 is always the floating one
local Terminal      = require('toggleterm.terminal').Terminal
local floating_term = Terminal:new({ direction = 'float', count = 1 })
floating_term:spawn()
vim.cmd [[ :1ToggleTermSetName terminal ]]
