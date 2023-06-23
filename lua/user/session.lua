-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- require("auto-session").setup({
-- 	log_level = vim.log.levels.ERROR,
-- 	auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
-- 	auto_session_use_git_branch = true,
--
-- 	auto_session_enable_last_session = false,
--
-- 	-- ⚠️ This will only work if Telescope.nvim is installed
-- 	session_lens = {
-- 		theme_conf = { border = true },
-- 		previewer = false,
-- 	},
-- })

-- vim.o.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"
require("persisted").setup({
	use_git_branch = true, -- create session files based on the branch of the git enabled repository
	autosave = true, -- automatically save session files when exiting Neovim
	should_autosave = function()
		-- do not autosave if the alpha dashboard is the current filetype
		if vim.bo.filetype == "alpha" then
			return false
		end
		return true
	end,
})
