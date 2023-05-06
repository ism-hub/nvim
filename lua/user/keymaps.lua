local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local wk = require("which-key")

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
-- 	normal_mode = "n"
-- 	insert_mode = "i"
-- 	visual_mode = "v"
-- 	visual_block_mode = "x"
-- 	term_mode = t
-- 	command_mode = c

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Open explorer
wk.register({
	["<leader>e"] = { "<cmd>NeoTreeRevealToggle<CR>", "Explorer" },
}, opts)

-- Open Symbol Outline
wk.register({
	["<leader>o"] = { "<cmd>SymbolsOutlineCR>", "Outline" },
}, opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
--[[ keymap("n", "<C-x>", ":bdelete!<CR>", opts) ]]
vim.keymap.set("n", "<C-x>", require("user.my_close").close_windows_before_buffers, opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Telescope
local builtin = require("telescope.builtin")
wk.register({
	["<leader>f"] = { name = "+search" },
	["<leader>ff"] = { builtin.find_files, "Find File" },
	["<leader>fg"] = { require("telescope").extensions.live_grep_args.live_grep_args, "Grep Files" },
	["<leader>fb"] = {
		function()
			builtin.live_grep({ grep_open_files = true })
		end,
		"Grep In Buffers",
	},
	["<leader>fB"] = { builtin.buffers, "Find Buffer" },
	["<leader>fh"] = { builtin.help_tags, "Find Help" },
	["<leader>f/"] = { builtin.current_buffer_fuzzy_find, "Find In Buffer" },
	["<leader>fm"] = { builtin.marks, "Find Mark" },
	["<leader>fr"] = { builtin.resume, "Resume Last Search" },
	["<leader>fR"] = { builtin.resume, "Last Search" },
	["<leader>fj"] = { builtin.jumplist, "Find Jump" },
	["<leader>fo"] = {
		function()
			builtin.oldfiles({ only_cwd = true })
		end,
		"Open Recent File",
	},
})

-- litee-calltree
wk.register({
	["<leader>fc"] = { vim.lsp.buf.incoming_calls, "Call Hierarchy" },
})

-- easy save
keymap("n", "<leader>w", ":w<CR>", opts)

-- scrolling
keymap("n", "<C-e>", "5<C-e>", opts)
keymap("n", "<C-y>", "5<C-y>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", "<", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP"', opts) -- holds on what we just pasted (in visual mode if we paste something over something2 it will copy something2 so the next time we will use past it will past something2)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
wk.register({
	["<C-t>"] = { "<cmd>Lspsaga term_toggle<CR>", "Toggle Term" },
}, { mode = "t" })
wk.register({
	["<C-t>"] = { "<cmd>Lspsaga term_toggle<CR>", "Toggle Term" },
})
-- Better terminal navigation
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
