local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "folke/which-key.nvim",
    -- "folke/neodev.nvim",
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
    -- Colorschemes
    "rebelot/kanagawa.nvim",
    -- cmp plugins
    -- LSP coc
    -- {
    --     'neoclide/coc.nvim',
    --     branch = 'release',
    -- },
    -- LSP native
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- lsp cmp
    {
        "hrsh7th/cmp-nvim-lsp",
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        -- snips
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
        "rafamadriz/friendly-snippets",
    },
    -- Telescope
    --[[ use("nvim-telescope/telescope.nvim") ]]
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end,
    },
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    -- Autopair
    "windwp/nvim-autopairs",
    -- comments
    "numToStr/Comment.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring", -- nvim Treesitter context comment string (in html file we can have js html ext..)
    -- git
    "lewis6991/gitsigns.nvim",
    -- nvim tree
    "nvim-tree/nvim-web-devicons",
    --[[ "nvim-tree/nvim-tree.lua", ]]
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },
    -- completion
    -- 9000+ Snippets
    "moll/vim-bbye",
    -- copy to system clipboard via terminal
    { "ojroques/nvim-osc52" },
    -- vim navigation
    "ggandor/lightspeed.nvim",
    -- show signature of functions while typing and the variable im in
    -- "ray-x/lsp_signature.nvim",
    -- git
    "tpope/vim-fugitive",
    -- zoom in/out of window <C-w>m
    "dhruvasagar/vim-zoom",

    "chentoast/marks.nvim",

    -- call-tree
    -- "ldelossa/litee.nvim",
    -- "ldelossa/litee-calltree.nvim",

    -- rust
    "simrat39/rust-tools.nvim",

    -- Debugging
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",

    -- folding
    { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
    -- floating term
    'voldikss/vim-floaterm',
    -- nice lsp ui (ui for code actions and more)
    {
        "glepnir/lspsaga.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            --Please make sure you install markdown and markdown_inline parser
            { "nvim-treesitter/nvim-treesitter" },
        },
    },
    -- outline
    -- {
    --     "SmiteshP/nvim-navbuddy",
    --     dependencies = {
    --         "SmiteshP/nvim-navic",
    --         "MunifTanjim/nui.nvim",
    --     },
    -- },
    -- session
    -- "rmagatti/auto-session",
    "olimorris/persisted.nvim",
    -- big file
    "LunarVim/bigfile.nvim",
    -- vs-code color-scheme
    "Mofiqul/vscode.nvim",
    "HiPhish/nvim-ts-rainbow2",
    -- startup screen
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    -- tabs
    "nanozuki/tabby.nvim",
    "LukasPietzschmann/telescope-tabs",
    -- diff
    "sindrets/diffview.nvim",
    -- yank ring
    "gbprod/yanky.nvim",
    -- substitute from yanked
    "gbprod/substitute.nvim",
    -- lsp highlight (no need for setup call)
    "RRethy/vim-illuminate",
    -- orgmode
    'nvim-orgmode/orgmode',
    'akinsho/org-bullets.nvim',
    'lukas-reineke/headlines.nvim',
})
