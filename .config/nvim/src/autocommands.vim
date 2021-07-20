augroup js_rescan_buffer
    autocmd!
    autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
    autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
augroup END

autocmd BufNewFile,BufRead *.svx set filetype=markdown
