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

" tagbar
Plugin 'majutsushi/tagbar'

" vim-easymotion(커서이동)
Plugin 'Lokaltog/vim-easymotion'

" 단어검색시 highlight
Plugin 'haya14busa/incsearch.vim'

" 코드 접기  new
Plugin 'pangloss/vim-simplefold'

" 문법확인
Plugin 'scrooloose/syntastic'

"여러 문자열 동시 강조 new good
Plugin 'MultipleSearch'

" 파일검색 및 파일 열기
Plugin 'ctrlpvim/ctrlp.vim'

" 스킨
Plugin 'nanotech/jellybeans.vim'

" indentline new good
Plugin 'Yggdroot/indentLine'

" Nerd Commenter (파일 타입에 따라서 자동으로 주석을 달아줌) new good 
Plugin 'scrooloose/nerdcommenter'

" 커서가 위치하지 않는 윈도우 바탕을 흐리게 만든다
Plugin 'blueyed/vim-diminactive'

call vundle#end()            " required
"filetype plugin indent on    " required

color jellybeans
let g:jellybeans_overrides = {
\    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
\              'ctermfg': 'Black', 'ctermbg': 'Yellow',
\              'attr': 'bold' },
\    'Comment': { 'guifg': 'cccccc' },
\}
let g:jellybeans_use_lowcolor_black = 1
let g:jellybeans_use_term_italics = 1
set guifont=Monaco:h10 noanti

"tagbar
map <Leader>tag <ESC>:TagbarToggle<CR>
map <Leader>bb <ESC>:%!xxd<CR>
map <Leader>bx <ESC>:%!xxd -r<CR>
nmap <C-H> <C-W>h                           "왼쪽 창으로 이동
nmap <C-J> <C-W>j                           "아래 창으로 이동
nmap <C-K> <C-W>k                           "윗 창으로 이동
nmap <C-L> <C-W>l                           "오른쪽 창으로 이동

"vim indentline
"let g:indentLine_bgcolor_term = 202
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 100
let g:indentLine_char = '¦'
let g:indentLine_first_char = ''
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'text', 'sh']
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
let g:indentLine_maxLines = 3000
let g:indentLine_enabled = 1
nnoremap \il :IndentLinesToggle

"nerdcommander
filetype plugin on
nmap // <leader>c<space>
vmap // <leader>cs

"Multiple Search
let g:MultipleSearchMaxColors=11
let g:MultipleSearchColorSequence="darkcyan,gray,LightCyan,LightBlue,LightGreen,blue,green,magenta,cyan,gray,brown"
let g:MultipleSearchTextColorSequence="white,DarkRed,black,black,black,white,black,white,red,black,white"
nnoremap  ,H :SearchReset 
nnoremap  ,h :Search 
"nnoremap  ,h :SearchBuffers 
"
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
let g:syntastic_c_compiler_options = "-std=c11 -Wall -Wextra -Wpedantic"

"vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#buffer_nr_show = 1       " buffer number를 보여준다
let g:airline#extensions#tabline#buffer_nr_format = '%s:' " buffer number format
let g:airline#extensions#tabline#formatter = 'default'

" 코드 접기
let g:SimpylFold_docstring_preview=1

"vim-incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

function! s:config_easyfuzzymotion(...) abort
return extend(copy({
\   'converters': [incsearch#config#fuzzy#converter()],
\   'modules': [incsearch#config#easymotion#module()],
\   'keymap': {"\": '(easymotion)'},
\   'is_expr': 0,
\   'is_stay': 1
\ }), get(a:, 1, {}))
endfunction
noremap  z/ incsearch#go(config_easyfuzzymotion())
"set hlsearch
"let g:incsearch#auto_nohlsearch = 1
"map n  <Plug>(incsearch-nohl-n)
"map N  <Plug>(incsearch-nohl-N)
"map *  <Plug>(incsearch-nohl-*)
"map #  <Plug>(incsearch-nohl-#)
"map g* <Plug>(incsearch-nohl-g*)
"map g# <Plug>(incsearch-nohl-g#)
"let g:incsearch#highlight = {
		"\   'match' : {
		"\     'group' : 'IncSearchUnderline',
		"\     'priority' : '10'
		"\   },
		"\   'on_cursor' : {
		"\     'priority' : '100'
		"\   },
		"\   'cursor' : {
		"\     'group' : 'ErrorMsg',
		"\     'priority' : '1000'
		"\   }
		"\ }

"vim -ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


" 세부 정보 출력
set nu " 라인 번호 표시
set title
set showmatch " 짝이 맞는 괄호를 보여줌
set ruler " 화면 우측에 현재 커서의 위치 표시

" 구문 강조 사용
if has("syntax")
  syntax on
endif

" 색깔 설정
set t_Co=256

" 들여쓰기 설정
set autoindent
set smartindent
set ts=4 " tabstop => 탭을 스페이스4칸으로
set sw=4 " shiftwidth => auto indent로 사용할 스페이스 개수
set smarttab " sw, ts, sts를 참조하여 탭 및 백스페이스 동작 보조

" 붙여넣기 설정
"set paste
set mouse-=a " mouse를 vim에서 못사용하게 하는 것

" 한글 입력 설정
set encoding=utf-8
set termencoding=utf-8

" 커서가 있는 줄을 강조함
set cursorline

" 상태바 표시를 항상한다
set laststatus=2
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

" 검색 설정 (대소문자 무시)
set ignorecase

set et
set nowrap
retab

" 투명도 설정
hi Normal guibg=NONE ctermbg=NONE

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
