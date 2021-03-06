set encoding=utf-8
scriptencoding utf-8
set helplang=ja



"dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}
"
call dein#add('kana/vim-operator-replace')


set nocompatible
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

" undo
set undodir=~/.vim/undo
set undofile

"file
set noswapfile
set nobackup

"indent
set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2

" commandline
set wildmenu
set wildmode=full

" history
set history=200

" format
set background=dark
set number
set formatoptions-=ro

" search
set incsearch
set hlsearch

syntax enable
set vb t_vb=
set clipboard&
set clipboard+=autoselect
set clipboard+=unnamed
set laststatus=2
set backspace=indent,eol,start
set completeopt=menuone,noinsert


inoremap <tab> <C-p>
inoremap <silent> jj <ESC>

" vim-operator-replace
map R <plug>(operator-replace)

" skin
set termguicolors
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_transparent_background = 1
let g:tokyonight_menu_selection_background = 'red'
let g:tokyonight_enable_italic = 1
let g:tokyonight_current_word = 'bold'

colorscheme tokyonight
