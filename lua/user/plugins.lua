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
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	-- Colorschemes
	"lunarvim/colorschemes", -- bunch of colorschemes we can use
	"folke/tokyonight.nvim",
	-- cmp plugins
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"hrsh7th/cmp-nvim-lsp",
	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use
	-- LSP
	"neovim/nvim-lspconfig", -- enable LSP
	--[[ use("williamboman/nvim-lsp-installer") -- simple to use language server ]]
	{
		"williamboman/mason.nvim",
		run = ":MasonUpdate", -- :MasonUpdate updates registry contents
		"williamboman/mason-lspconfig.nvim",
	},
	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
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
	"kyazdani42/nvim-web-devicons",
	"kyazdani42/nvim-tree.lua",
	-- bufferline
	--use("akinsho/bufferline.nvim")
	{ "akinsho/bufferline.nvim", version = "v2.*", dependencies = "kyazdani42/nvim-web-devicons" },
	"moll/vim-bbye",
	-- copy to system clipboard via terminal
	{ "ojroques/nvim-osc52" },
	-- vim navigation
	"ggandor/lightspeed.nvim",
	-- show signature of functions while typing and the variable im in
	"ray-x/lsp_signature.nvim",
	-- git
	"tpope/vim-fugitive",
	-- zoom in/out of window <C-w>m
	"dhruvasagar/vim-zoom",

	"chentoast/marks.nvim",

	-- call-tree
	"ldelossa/litee.nvim",
	"ldelossa/litee-calltree.nvim",

	-- rust
	"simrat39/rust-tools.nvim",

	-- Debugging
	"nvim-lua/plenary.nvim",
	"mfussenegger/nvim-dap",
	"theHamsta/nvim-dap-virtual-text",
	"rcarriga/nvim-dap-ui",
})
