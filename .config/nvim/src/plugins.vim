"{ Plugin installation
"{{ Vim-plug related settings.
" The root directory to install all plugins.
let g:plug_home=expand(stdpath('data') . '/plugged')

" Use fastgit for clone on Linux systems.
let g:plug_url_format = 'https://hub.fastgit.org/%s.git'

if empty(glob(g:plug_home))
silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"autocmd VimEnter * PlugInstall
"autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
"}}

call plug#begin(g:plug_home)
"{{ Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release', 'build': 'yarn install'}

" Godot semantic highlighting
Plug 'calviken/vim-gdscript3'

" Unity
Plug 'OmniSharp/omnisharp-vim'

" JS Syntax Highlighting
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
"}}

"{{ Search
" Super fast movement with vim-sneak
Plug 'justinmk/vim-sneak'

" Clear highlight search automatically for you
Plug 'romainl/vim-cool'

" File and tag search
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
"}}

"{{ UI
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
"}}

"{{ Navigation/Tags
" plugin to manage your tags
Plug 'ludovicchabant/vim-gutentags'
" show file tags in vim window
Plug 'liuchengxu/vista.vim'
Plug 'preservim/nerdtree'
"}}

"{{ File editting
" Snippet engine and snippet template
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Comment plugin
Plug 'tpope/vim-commentary'

" Show undo history visually
Plug 'simnalamburt/vim-mundo'

" Handy unix command inside Vim (Rename, Move etc.)
Plug 'tpope/vim-eunuch'

" Repeat vim motions
Plug 'tpope/vim-repeat'

" Highlight URLs inside vim
Plug 'itchyny/vim-highlighturl'
"}}

"{{ Git
" Show git change (change, delete, add) signs in vim sign column
Plug 'mhinz/vim-signify'

" Git command inside vim
Plug 'tpope/vim-fugitive'
Plug 'APZelos/blamer.nvim'
"}}

"{{ Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Faster footnote generation
Plug 'vim-pandoc/vim-markdownfootnotes', { 'for': 'markdown' }

" Vim tabular plugin for manipulate tabular, required by markdown plugins
Plug 'godlygeek/tabular', {'on': 'Tabularize'}

" Markdown JSON header highlight plugin
Plug 'elzr/vim-json', { 'for': ['json', 'markdown'] }
"}}

"{{ Text
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'

" Add indent object for vim (useful for languages like Python)
Plug 'michaeljsmith/vim-indent-object'
"}}

"{{ Misc
Plug 'andymass/vim-matchup'

" Smoothie motions
Plug 'psliwka/vim-smoothie'

Plug 'tpope/vim-scriptease'

" Asynchronous command execution
Plug 'skywind3000/asyncrun.vim'
" Another asynchronous plugin
" Plug 'tpope/vim-dispa

" Session management plugin
Plug 'tpope/vim-obsession'

" Visual selection stats
Plug 'wgurecky/vimSum'
Plug 'ojroques/vim-oscyank'
"}}

call plug#end()
"}

"{ Plugin configuration
"{{ Autocompletion
let g:coc_global_extensions=['coc-omnisharp', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-jedi', 'coc-jest', 'coc-java', 'coc-yaml', 'coc-pairs', 'coc-fish', 'coc-rls', 'coc-html']

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
"}}
"
"{{ UI
let g:airline_theme = 'spaceduck'

" Tabline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Show buffer number for easier switching between buffer,
" see https://github.com/vim-airline/vim-airline/issues/1149
let g:airline#extensions#tabline#buffer_nr_show = 1

" Buffer number display format
let g:airline#extensions#tabline#buffer_nr_format = '%s. '

" Whether to show function or other tags on status line
let g:airline#extensions#vista#enabled = 1
let g:airline#extensions#gutentags#enabled = 1

" Skip empty sections if there are nothing to show,
" extracted from https://vi.stackexchange.com/a/9637/15292
let g:airline_skip_empty_sections = 1

" Whether to use powerline symbols, see https://vi.stackexchange.com/q/3359/15292
let g:airline_powerline_fonts = 0

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'

" Only show git hunks which are non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" Speed up airline
let g:airline_highlighting_cache = 1
"
" Do not change working directory when opening files.
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1
"}}

"{{ File Editting
" Trigger configuration. Do not use <tab> if you use YouCompleteMe
let g:UltiSnipsExpandTrigger='<tab>'

" Do not look for SnipMate snippets
let g:UltiSnipsEnableSnipMate = 0

" Shortcut to jump forward and backward in tabstop positions
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snips']

let g:mundo_verbose_graph = 0
let g:mundo_width = 80
nnoremap <silent> <Space>u :MundoToggle<CR>
"}}

"{{ Search
" Use sneak label mode
let g:sneak#label = 1

nmap f <Plug>Sneak_s
xmap f <Plug>Sneak_s
onoremap <silent> f :call sneak#wrap(v:operator, 2, 0, 1, 1)<CR>
nmap F <Plug>Sneak_S
xmap F <Plug>Sneak_S
onoremap <silent> F :call sneak#wrap(v:operator, 2, 1, 1, 1)<CR>

" Immediately after entering sneak mode, you can press f and F to go to next
" or previous match
let g:sneak#s_next = 1

nmap *  <Plug>(asterisk-z*)
nmap #  <Plug>(asterisk-z#)
xmap *  <Plug>(asterisk-z*)
xmap #  <Plug>(asterisk-z#)

" Do not use cache file
let g:Lf_UseCache = 0
" Refresh each time we call leaderf
let g:Lf_UseMemoryCache = 0

" Ignore certain files and directories when searching files
let g:Lf_WildIgnore = {
\ 'dir': ['.git', '__pycache__', '.DS_Store', 'node_modules'],
\ 'file': ['*.exe', '*.dll', '*.so', '*.o', '*.pyc', '*.jpg', '*.png',
\ '*.gif', '*.svg', '*.ico', '*.db', '*.tgz', '*.tar.gz', '*.gz',
\ '*.zip', '*.bin', '*.pptx', '*.xlsx', '*.docx', '*.pdf', '*.tmp',
\ '*.wmv', '*.mkv', '*.mp4', '*.rmvb', '*.ttf', '*.ttc', '*.otf']
\}

" Do not show fancy icons for Linux server.
let g:Lf_ShowDevIcons = 0

" Only fuzzy-search files names
let g:Lf_DefaultMode = 'NameOnly'

" Disable default mapping
let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''

" set up working directory for git repository
let g:Lf_WorkingDirectoryMode = 'a'

" Search files in popup window
nnoremap <silent> <leader>f :<C-U>Leaderf file --popup<CR>
" Search vim help files
nnoremap <silent> <leader>h :<C-U>Leaderf help --popup<CR>
" Search tags in current buffer
nnoremap <silent> <leader>t :<C-U>Leaderf bufTag --popup<CR>
"}}

"{{ Navigation and tags
" The path to store tags files, instead of in the project root.
let g:gutentags_cache_dir = stdpath('cache') . '/ctags'
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_exclude = ['*.md', '*.html', '*.json', '*.toml', '*.css', '*.js',]

let g:vista#renderer#icons = {
      \ 'member': '',
      \ }

" Do not echo message on command line
let g:vista_echo_cursor = 0
" Stay in current window when vista window is opened
let g:vista_stay_on_open = 0

augroup vista_conf
  autocmd!
  " Double mouse click to go to a tag
  autocmd FileType vista* nnoremap <buffer> <silent>
        \ <2-LeftMouse> :<C-U>call vista#cursor#FoldOrJump()<CR>
augroup END

nnoremap <silent> <Space>t :<C-U>Vista!!<CR>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
"}}

"{{ Git
let g:signify_vcs_list = [ 'git' ]

" Change the sign for certain operations
let g:signify_sign_change = '~'

nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gpl :Git pull<CR>
" Note that to use bar literally, we need backslash it, see also `:h :bar`.
nnoremap <silent> <leader>gpu :15split \| term git push

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
"}}

"{{ Markdown 
" Disable header folding
let g:vim_markdown_folding_disabled = 1

" Whether to use conceal feature in markdown
let g:vim_markdown_conceal = 1

" Disable math tex conceal and syntax highlight
let g:tex_conceal = ''
let g:vim_markdown_math = 0

" Support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

" Let the TOC window autofit so that it doesn't take too much space
let g:vim_markdown_toc_autofit = 1
"}}
"" Disable header folding
let g:vim_markdown_folding_disabled = 1

" Whether to use conceal feature in markdown
let g:vim_markdown_conceal = 1

" Disable math tex conceal and syntax highlight
let g:tex_conceal = ''
let g:vim_markdown_math = 0

" Support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

" Let the TOC window autofit so that it doesn't take too much space
let g:vim_markdown_toc_autofit = 1
"}}

"{{ Text
" Map s to nop since s in used by vim-sandwich. Use cl instead of s.
nmap s <Nop>
omap s <Nop>
"}}

"{{ Misc
let g:asyncrun_open = 6
"}}
"}
