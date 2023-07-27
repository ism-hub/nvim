-- based on https://github.com/voldikss/vim-floaterm/issues/208#issuecomment-747829311
-- overriding gf to open the file in the last window and not the terminal itself
vim.cmd([[
function s:open_in_normal_window() abort
  let f = findfile(expand('<cfile>'))
  if !empty(f)
    if has_key(nvim_win_get_config(win_getid()), 'anchor') " if the term floating hide it first
        FloatermHide
        execute 'e ' . f
    end
  endif
endfunction

autocmd FileType floaterm nnoremap <silent><buffer> gf :call <SID>open_in_normal_window()<CR>
]])

vim.g.floaterm_height=0.95
vim.g.floaterm_width=0.9
-- vim.g.floaterm_autoinsert = false
