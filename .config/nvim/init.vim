" Inspired by https://github.com/jdhao/nvim-config

" { Main configuration
let g:config_file_list = ['options.vim',
  \ 'autocommands.vim',
  \ 'mappings.vim',
  \ 'plugins.vim',
  \ 'ui.vim'
  \ ]

let g:nvim_config_root = expand('<sfile>:p:h')

for s:fname in g:config_file_list
  execute printf('source %s/src/%s', g:nvim_config_root, s:fname)
endfor
" }
