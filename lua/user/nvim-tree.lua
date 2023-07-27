-- from docs
--[[ local function my_on_attach(bufnr) ]]
--[[ 	local api = require("nvim-tree.api") ]]
--[[ 	local function opts(desc) ]]
--[[ 		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } ]]
--[[ 	end ]]
--[[ 	api.config.mappings.default_on_attach(bufnr) ]]
--[[ 	-- your removals and mappings go here ]]
--[[]]
--[[ 	vim.keymap.set("n", "<C-y>", api.node.open.vertical, opts("Open: Vertical Split")) ]]
--[[ 	vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split")) ]]
--[[ end ]]
--[[]]
--[[ require("nvim-tree").setup({ ]]
--[[ 	on_attach = my_on_attach, ]]
--[[ 	view = { ]]
--[[ 		preserve_window_proportions = true, ]]
--[[ 		-- float = { ]]
--[[ 		-- 	enable = true, ]]
--[[ 		-- }, ]]
--[[ 	}, ]]
--[[ }) ]]
require("neo-tree").setup({
	filesystem = {
		follow_current_file = {enabled = true},
		use_libuv_file_watcher = true,
	},
	buffers = {
		follow_current_file = {enabled = true},
	},
	--[[ sources = { ]]
	--[[ 	"filesystem", ]]
	--[[ 	"buffers", ]]
	--[[ 	"git_status", ]]
	--[[ 	"document_symbols", ]]
	--[[ }, ]]
})
