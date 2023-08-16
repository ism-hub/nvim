-- based on https://github.com/voldikss/vim-floaterm/issues/208#issuecomment-747829311
-- and https://www.reddit.com/r/vim/comments/780eyl/how_to_configure_vim_to_jump_to_file_line_and/
-- overriding gf to open the file in the last window and not the terminal itself
vim.cmd([[
function s:open_in_normal_window() abort
  " get the file string of the form <fname>:<line>:<col>
  let fileInfoString = expand("<cWORD>")
  let fileInfo = split(fileInfoString, ":")

  " get <fname>
  let filePath = findfile(fileInfo[0], join(g:WorkspaceFolders, ','))

  " open it
  if !empty(filePath)
    if has_key(nvim_win_get_config(win_getid()), 'anchor') " if the term floating hide it first
        let g:floaterm_autoinsert = v:false
        FloatermHide
        execute 'e ' . filePath

        " goto line num
        if len(fileInfo) > 1
          let lineNum = fileInfo[1]
          execute ':' . lineNum
        endif

        " goto col
        if len(fileInfo) > 2
          let col = fileInfo[2]
          execute 'normal! '  . col . '|'
        endif

    endif
  endif
endfunction

autocmd FileType floaterm nnoremap <silent><buffer> gf :call <SID>open_in_normal_window()<CR>
]])

vim.g.floaterm_height = 0.95
vim.g.floaterm_width = 0.9
-- vim.g.floaterm_autoinsert = false
