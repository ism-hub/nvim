

-- By default you can copy up to 100000 characters at once. If your terminal supports it, you can raise that limit with
-- let g:oscyank_max_length = 1000000

-- The plugin treats tmux, screen and kitty differently than other terminal emulators. The plugin should automatically detects the terminal used but you can bypass detection with
-- let g:oscyank_term = 'tmux'  " or 'screen', 'kitty', 'default'

-- By default a confirmation message is echoed after text is copied. This can be disabled with
vim.cmd [[ let g:oscyank_silent = v:true ]]

-- Content will be copied to clipboard after any yank operation:
vim.cmd [[ autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif ]]

