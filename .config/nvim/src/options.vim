
"{ Builtin options

" Paste mode toggle, it seems that Neovim's bracketed paste mode
" does not work very well for nvim-qt, so we use good-old paste mode
set pastetoggle=<F12>

" Split window below/right when creating new windows
set splitbelow splitright

" Always use clipboard
if !empty(provider#clipboard#Executable())
  set clipboard+=unnamedplus
endif

" Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
set noswapfile

" Tabs
set tabstop=4       " visual spaces per tab
set softtabstop=4   " spaces oer tab when editing
set shiftwidth=4    " spaces oer tab in autoindent
set expandtab       " tabs -> space
set shiftround

set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》

" Relative line numbers
set number relativenumber

set ignorecase smartcase

set fileencoding=utf-8

" Break lines
set linebreak
set showbreak=↪

set cursorline

" Scroll padding
set scrolloff=3

" Because vim-airline will
set noshowmode

set fileformats=unix,dos

set inccommand=nosplit  " Show the result of substitution in real time for preview

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**,*/node_modules/**
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz
set wildignorecase  " ignore file and dir name cases in cmd-completion

set confirm

set visualbell noerrorbells
set history=300

" Use list mode and customized listchars
set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣

set autowrite

" Persist undo after closing
set undofile

set shortmess+=c

" Completion behaviour
" set completeopt+=noinsert  " Auto select the first completion entry
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window

set pumheight=10

" Insert mode key word completion setting
set complete+=kspell complete-=w complete-=b complete-=u complete-=t

set spelllang=en,spa

set virtualedit=block

set nojoinspaces

set synmaxcol=200
set nostartofline

"}
