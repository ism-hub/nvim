local null_ls = require("null-ls")
local cspell = require('cspell')

local cspell_config = {
    find_json = function(cwd)
        return vim.fn.expand("~/.config/nvim/cspell.json")
    end,
    -- filetypes = { "lua", "rust" },
}

null_ls.setup({
    sources = {
        cspell.diagnostics.with({
            config = cspell_config,
            -- Force the severity to be HINT
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = vim.diagnostic.severity.HINT
            end,
        }),
        cspell.code_actions.with({
            config = cspell_config,
        }),
    },
})
