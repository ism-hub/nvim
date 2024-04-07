local configs = require("nvim-treesitter.configs")
configs.setup({
    ensure_installed = { "cpp", "markdown", "markdown_inline", "yaml", "org", "lua", "vimdoc", "rust" },
    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 700 * 1024 -- 700 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        -- additional_vim_regex_highlighting = { 'org' },
    },
    -- rainbow = {
    --     enable = true,
    --     -- list of languages you want to disable the plugin for
    --     -- disable = { "jsx", "cpp" },
    --     -- Which query to use for finding delimiters
    --     query = "rainbow-parens",
    --     -- Highlight the entire buffer all at once
    --     strategy = require("ts-rainbow").strategy.global,
    --     hlgroups = {
    --         "TSRainbowYellow",
    --         "TSRainbowViolet",
    --         "TSRainbowBlue",
    --         "TSRainbowOrange",
    --         "TSRainbowGreen",
    --         "TSRainbowCyan",
    --         "TSRainbowRed",
    --     },
    -- },
    -- incremental_selection = {
    --     enable = true,
    --     keymaps = {
    --         init_selection = "<cr>",
    --         node_incremental = "<cr>",
    --         scope_incremental = "grc",
    --         node_decremental = "<BS>",
    --     },
    -- },
})
