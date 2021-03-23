set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" git 관련 플러그인 
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'git://git.wincent.com/command-t.git'

" vim 상태바(airline)
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" vim-easymotion(커서이동)
Plugin 'Lokaltog/vim-easymotion'

" 단어검색시 highlight
Plugin 'haya14busa/incsearch.vim'

" 디렉터리 검색 nerdtree
Plugin 'scrooloose/nerdtree'

" 문법확인
Plugin 'scrooloose/syntastic'

" 파일검색 및 파일 열기
Plugin 'ctrlpvim/ctrlp.vim'

" 스킨
Plugin 'nanotech/jellybeans.vim'

" tagbar
Plugin 'majutsushi/tagbar'

" indent-guides
Plugin 'nathanaelkane/vim-indent-guides'

" 뭐였지
Plugin 'blueyed/vim-diminactive'

call vundle#end()            " required
"filetype plugin indent on    " required

"NERDTree ON 단축키를 "\nt"로 설정
map <Leader>nt <ESC>:NERDTree<CR>
let NERDTreeShowHidden=1
" let NERDTreeQuitOnOpen=1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|vendor$',
    \ 'file': '\v\.(exe|so|dll)$'
\ }

"vim-indent-guides setting
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

"vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#buffer_nr_show = 1       " buffer number를 보여준다
let g:airline#extensions#tabline#buffer_nr_format = '%s:' " buffer number format
let g:airline#extensions#tabline#formatter = 'default'
nnoremap <C-S-t> :enew<Enter>         " 새로운 버퍼를 연다
nnoremap <C-F5> :bprevious!<Enter>    " 이전 버퍼로 이동
nnoremap <C-F6> :bnext!<Enter>        " 다음 버퍼로 이동
nnoremap <C-F4> :bp <BAR> bd #<Enter> " 현재 버퍼를 닫고 이전 버퍼로 이동
nnoremap , :bn<CR> " 콤마(,)를 사용하여 다음 버퍼로 이동
nnoremap . :bd<CR> " 콤마(,)를 사용하여 다음 버퍼로 이동

"vim-incsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
let g:incsearch#highlight = {
		\   'match' : {
		\     'group' : 'IncSearchUnderline',
		\     'priority' : '10'
		\   },
		\   'on_cursor' : {
		\     'priority' : '100'
		\   },
		\   'cursor' : {
		\     'group' : 'ErrorMsg',
		\     'priority' : '1000'
		\   }
		\ }

"vim -ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

color jellybeans

" Tag List 환경설정
filetype on                                 "vim filetype on

"Source Explorer 환경설정
" nmap <F8> :SrcExplToggle<CR>                "F8 Key = SrcExpl Toggling
nmap <F9> :TagbarToggle<CR>                 "4. vi에서 :PluginInstall하기
nmap <C-H> <C-W>h                           "왼쪽 창으로 이동
nmap <C-J> <C-W>j                           "아래 창으로 이동
nmap <C-K> <C-W>k                           "윗 창으로 이동
nmap <C-L> <C-W>l                           "오른쪽 창으로 이동

" 세부 정보 출력
set nu
set title
set showmatch
set ruler

" 구문 강조 사용
if has("syntax")
 syntax on
endif

" 색깔 설정
set t_Co=256

" 들여쓰기 설정
set autoindent
set smartindent
set ts=4
set sw=4
set et
set smarttab

" 붙여넣기 설정
set paste
set mouse-=a

" 한글 입력 설정
set encoding=utf-8
set termencoding=utf-8

" 커서가 있는 줄을 강조함
set cursorline

" 상태바 표시를 항상한다
set laststatus=2
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

" 검색 설정
set ignorecase

" 마지막으로 수정된 곳에 커서를 위치함
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif
" Markdown 문법 설정 (Git 에서 사용)
augroup markdown
    " remove previous autocmds
    autocmd!
    " set every new or read *.md buffer to use the markdown filetype
    autocmd BufRead,BufNew *.md setf markdown
augroup END
