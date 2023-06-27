-- :help options
vim.opt.backup = false				-- creates a backup file
vim.opt.clipboard = "unnamedplus"		-- allows neovim to access the system clipboard
vim.opt.cmdheight = 2				-- more space in the neovim  command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" }	-- mostly just for cmp
vim.opt.conceallevel = 0			-- so that `` is visible in markdowen files
vim.opt.fileencoding = "utf-8"			-- the encoding written to a file
vim.opt.hlsearch = true 			-- highlight all matches on previous search pattern
vim.opt.ignorecase = true			-- ignore case in search patterns
vim.opt.mouse = "a"				-- allow the mouse to be used in neovim
vim.opt.pumheight = 10 				-- pop up menue height
-- vim.opt.showmode = false			-- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2				-- always show tabs
vim.opt.smartcase = true			-- smart case
vim.opt.smartindent = true			-- make indenting smarter again
vim.opt.splitbelow = true			-- force all horizontal splits to go below  current window
vim.opt.splitright = true			-- force all vertical splits to go to the right of current window
vim.opt.swapfile = false			-- create a swapfile
vim.opt.termguicolors = true			-- set term gui colors (most terminals support this)
vim.opt.timeout = true
vim.opt.timeoutlen = 1000			-- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true				-- enable persistent undo
vim.opt.updatetime = 300			-- faster completion (4000ms default)
vim.opt.writebackup = false			-- if a file is being edited by another program (or was written to file while editing with another program), it is n
vim.opt.expandtab = true			-- convert tabs to spaces
vim.opt.shiftwidth = 4			-- the number of spaces inserted foreach identation
vim.opt.tabstop = 4				-- insert 2 spaces for a tab
vim.opt.cursorline = true			-- highlight the current line
vim.opt.number = true				-- set numbered lines
vim.opt.relativenumber = false			-- set relative numbered lines
vim.opt.numberwidth = 4				-- set number column width to 4 {default 2}
vim.opt.signcolumn = "yes"			-- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false				-- displays lines as one long line
vim.opt.scrolloff = 8				-- 
vim.opt.sidescrolloff = 8			--
vim.opt.guifont = "monospace:h17"		-- the font used in graphical neovim applications
vim.opt.shortmess:append "c"			--
vim.opt.completeopt = {'menu', 'menuone','noinsert' ,'noselect'}
vim.opt.tw = 500
vim.cmd [[set number relativenumber]]			-- treats '-' in a word as one word, so if we do <dw> on "asd-fgh" we  will delete the whole word and not just "asd"
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]			-- treats '-' in a word as one word, so if we do <dw> on "asd-fgh" we  will delete the whole word and not just "asd"
vim.cmd [[set formatoptions-=cro]] 		--TODO: this doesn't seems to work (what it even suppose to do) 

-- highlighing (must be b4 we load plugins (cuz that plugin doesn't have setup..)) (plugin - RRethy/vim-illuminate)
vim.cmd([[
hi def IlluminatedWordText guifg=none guibg=Grey30
hi def IlluminatedWordRead guifg=none guibg=Grey30
hi def IlluminatedWordWrite guifg=none guibg=Grey30
]])
