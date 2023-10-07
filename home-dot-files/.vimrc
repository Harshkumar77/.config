" the mother of all remaps
imap kj <Esc>

" new vim
set nocompatible
filetype plugin on
syntax on
colorscheme peachpuff

let mapleader = " "
let maplocalleader = " "

nnoremap <leader>q :wq<cr>
nnoremap <leader>Q :qa!<cr>

"better focus change
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"only spaces no tabs
set expandtab
retab!
set shiftwidth=2
retab

"Super o
nnoremap <leader>o i<Esc>O<Esc>o
" soft delete keeping the line empty
nnoremap ds 0D

"+ and - for increment and decrementing a number
nnoremap - <C-x>
nnoremap + <C-a>

" Disable annoying beeping
set noerrorbells
set vb t_vb= "

"relative 
set number relativenumber

"auto semicolon
noremap <leader>; A;<Esc>o

"search
set incsearch
"no highlight on search
set nohlsearch

"Move lines
noremap <leader>j Vxp
noremap <leader>k VxkP


" # Enable mouse mode
set mouse=a

" # Clipboard
" this will copy to system clipboard
" set clipboard = 'unnamedplus' 
vnoremap Y "+y
" copy whole file

noremap <leader>y ggVGy<C-o>zz
noremap <leader>Y ggVG"+y<C-o>zz

" Enable break indent
set breakindent

" Save undo history
set undofile

" Case-insensitive searching UNLESS \C or capital in search
set ignorecase 
set smartcase 

" Keep signcolumn on by default
set scl=yes

" Decrease update time
set updatetime=250
set timeoutlen=300

" Set completeopt to have a better completion experience
set completeopt="menuone,noselect"

" NOTE: You should make sure your terminal supports this
set termguicolors

" fold
set foldmethod=syntax
" Disable folding at startup.
"set nofoldenable                    

"file explorer
nnoremap <leader>f :Explore<cr>
" nnoremap <leader>l :Lexplore %:p:h<CR>
nnoremap <leader>l :Lexplore<CR>
let g:netrw_keepdir = 0
let g:netrw_winsize = 30
let g:netrw_banner = 0
let g:netrw_localcopydircmd = 'cp -r' 
"doesnt work
let g:netrw_localrmdir='rm -r' 
"idk what it is
hi! link netrwMarkFile Search 
"default tree
let g:netrw_liststyle = 3 

"annoying swp files
set noswapfile

nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

set cursorline
set colorcolumn=81

tnoremap kj <C-\><C-n>

"tabs
nnoremap tt g<Tab>
nnoremap to :tabonly<cr>
nnoremap tn :tabnew<cr>
nnoremap tf <C-w>gf
nnoremap ts :tabnew<cr>:terminal<cr>a
nnoremap H :tabprevious<cr>
nnoremap L :tabnext<cr>
nnoremap <C-s> :tabnew ~/notes/scrathpad.md<cr>
set tabpagemax=3

" "buffer
" nnoremap <leader>1 :bp<cr>
" nnoremap <leader>2 :bn<cr>

" disable line wraping
set nowrap

" vimwiki
let g:vimwiki_list = [{'path': '~/notes/',
                        \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_diary_caption_level=-1
let g:vimwiki_auto_header=1

"set list
" didn't like it maybe future its eol character
"set listchars+=eol:󰦷 

"jump to last file
nnoremap s <C-^>

"only one status line
set ls=3
" command line only show when trigger ******* set cmdheight=0

" not worjing now
set dict='/usr/share/dict/words'
inoremap <C-d> <C-x><C-k>

"wraping toggle
nnoremap <leader>W :set wrap!<cr>

"Format
nnoremap <leader>F :Wf<cr>


