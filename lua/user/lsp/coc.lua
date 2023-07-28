-- :CocList marketplace python to search extension that name contains python
vim.g.coc_global_extensions = { 'coc-marketplace', 'coc-nav' }

vim.cmd([[
hi CocUnderline gui=underline term=underline
hi CocErrorHighlight ctermfg=red  guifg=#c4384b gui=underline term=underline
hi CocWarningHighlight ctermfg=yellow guifg=#c4ab39 gui=underline term=underline
]])

-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300
