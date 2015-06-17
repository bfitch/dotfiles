:let mapleader = " "

set nocompatible
filetype off

"-----------------VUNDLE ----------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Railscasts-Theme-GUIand256color'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'godlygeek/tabular'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-cucumber'
Plugin 'kien/ctrlp.vim'
" Plugin 'SuperTab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Plugin 'briancollins/vim-jst'
Plugin 'leshill/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'tComment'
Plugin 'ack.vim'
Plugin 'rking/ag.vim'
Plugin 'pthrasher/conqueterm-vim'
Plugin 'vim-scripts/matchit.zip'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'Bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'Yggdroot/indentLine'
Plugin 'mxw/vim-jsx'

" All of your Plugins must be added before the following line
 call vundle#end()            " required
 filetype plugin indent on    " required

"-----------------AIRLINE ----------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"-----------------SYNTASTIC --------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

"-----------------CONFIG -----------------------
set number
set noswapfile
set nobackup
set nowb
set guioptions-=r
set guioptions-=L
set guioptions-=T
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb= " Turn off bell sound

set nowrap         " Wrap long lines
set autoindent     " Indent at the same level of the previous line
set copyindent     " copy previous indentation
set shiftwidth=2   " Use indents of 4 spaces
set softtabstop=2  " Let backspace delete indent
set expandtab      " Tabs are spaces, not tabs

set splitbelow
set splitright

set ignorecase     " ignore case when searching
set smartcase      " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab       " insert tabs on the start of a line according to shiftwidth, not tabstop
set incsearch      " show search matches as you type
set hlsearch       " highlight matches

match ErrorMsg '\s\+$' " highlight trailing whitespace

"-----------------CTRL-P------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'public\|node_modules\|DS_Store\|git'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

:map <C-F> :CtrlPClearAllCaches<CR>

"---------------Cucumber Alignment--------------
" Align cucumber tables as you type
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

vmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a. :Tabularize /=><CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

"-----------------------------------------------
" Opens an edit command with the path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" Window navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>
nmap tt <C-W>

" Turn on syntax highlighting when we have colors or gui is running
if &t_Co > 2 || has("gui_running") " &t_Co > 2 => we have colors
  syntax on
  " set guifont=Monaco:h12
  set guifont=Meslo\ LG\ S\ for\ Powerline:h13 " Installed from: https://github.com/powerline/fonts
  let g:airline_powerline_fonts = 1
endif

let g:jsx_ext_required = 0 "highlight jsx in .js files

set pastetoggle=<F2>   " Hit <F2> to disable/enable autoindention for paste

:noremap <Leader> :NERDTreeToggle<CR>

:nnoremap <C-T> :!ctags -R --exclude=.git --exclude=log --exclude=public --exclude=vendor --exclude=node_modules --exclude=bower_components<CR> " Generate CTags file
:nnoremap <Leader>r :call RunCFile() <CR>

function! RunCFile()
  let file = expand("%:t:r")
  execute ":make clean && make && ./".file
endfunction

colorscheme railscasts

map <Leader>ss :call OpenSpecFile() <CR>
map <Leader>rs :call RunSpecExample() <CR>
map <Leader>rr :call RunSpecFile() <CR>
map <Leader>rsd :call RunSpecExampleDebug() <CR>
map <Leader>rrd :call RunSpecFileDebug() <CR>
map <Leader>js :call RunJsSpec() <CR>
noremap <Leader>f :let @* = expand("%:p") <CR>

function! RunSpecExample()
  let file = expand('%:p')
  let line = line('.')
  execute "ConqueTermSplit zeus rspec ".file." --line ".line
endfunction

function! RunSpecFile()
  let file = expand('%:p')
  " execute "!zeus rspec ".file." --no-color"
  execute "ConqueTermSplit zeus rspec ".file
endfunction

function! RunSpecExampleDebug()
  let file = expand('%:p')
  let line = line('.')
  execute "ConqueTermTab zeus rspec ".file." --line ".line
endfunction

function! RunSpecFileDebug()
  let file = expand('%:p')
  " execute "!zeus rspec ".file." --no-color"
  execute "ConqueTermTab zeus rspec ".file
endfunction

let g:ConqueTerm_Color = 0
let g:ConqueTerm_TERM = 'xterm-256color'
nmap <silent> <Leader>c :execute 'ConqueTermSplit bash --login'<CR>
