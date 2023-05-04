null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.diagnostics.cspell.with({
            filetypes = { "lua", "rust" },
            -- Force the severity to be HINT
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = vim.diagnostic.severity.HINT
            end,
        }),
        null_ls.builtins.code_actions.cspell.with({
            config = {
                --[[ find_json = function(cwd) ]]
                --[[     return vim.fn.expand(cwd .. "/cspell.json") ]]
                --[[ end, ]]
                --[[ on_success = function(cspell_config_file, params) ]]
                --[[     -- format the cspell config file ]]
                --[[     os.execute( ]]
                --[[         string.format( ]]
                --[[             "cat %s | jq -S '.words |= sort' | tee %s > /dev/null", ]]
                --[[             cspell_config_file, ]]
                --[[             cspell_config_file ]]
                --[[         ) ]]
                --[[     ) ]]
                --[[ end, ]]
            },
            filetypes = { "lua", "rust" },
        }),
        formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
        formatting.black.with({ extra_args = { "--fast" } }),
        -- formatting.yapf,
        formatting.stylua,
        --[[ diagnostics.flake8, ]]
    },
})
