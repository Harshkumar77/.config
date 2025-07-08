
" the mother of all remaps
imap kj <Esc>
unmap <Space>
noremap : ;
noremap ; :

noremap j gjzz
noremap k gkzz
" Obsidian

exmap foldcurrent obcommand editor:toggle-fold
noremap zo :foldcurrent<CR> 

exmap foldall obcommand editor:fold-all
noremap zR :foldall<CR> 


exmap unfoldall obcommand editor:unfold-all
noremap zM :unfoldall<CR> 

exmap outlineopen obcommand outline:open
noremap go :outlineopen<CR> 

map gp :pasteinto<CR>

exmap tabnext obcommand workspace:next-tab
map gt :tabnext<CR>
exmap tabprev obcommand workspace:previous-tab
map gT :tabprev<CR>

exmap list obcommand editor:cycle-list-checklist
noremap g. :list<CR>

exmap nlist obcommand editor:toggle-numbered-list
noremap g> :nlist<CR>

exmap back obcommand app:go-back
exmap forward obcommand app:go-forward
noremap gb :back<CR>
noremap gn :forward<CR>

exmap linknewtab obcommand editor:open-link-in-new-window
noremap gF :linknewtab<CR>

exmap activeFile obcommand file-explorer:reveal-active-file
noremap \\ :activeFile<CR>

exmap bmk obcommand bookmarks:open
noremap <Space>gb :bmk<CR>

exmap tag obcommand tag-pane:open
noremap <Space>gt :tag<CR>

exmap omnisearch obcommand omnisearch:show-modal
noremap <Space>sf :omnisearch<CR>

# exmap unique obcommand
# noremap <Space>sn :unique<CR>

exmap rename obcommand workspace:edit-file-title
noremap <Space>rn :rename<CR>


exmap reload obcommand app:reload
noremap <Space>rr :reload<CR>

"pin 
noremap <Space>tp A<Space>#p<Esc>^
noremap <Space>tP A<Space>#P<Esc>^
noremap <Space>tu :s/#p//g<CR>/fffffffff<CR>^

"source mode
exmap raw obcommand editor:toggle-source
noremap <Space>tr :raw<CR>
voremap <Space>tr :raw<CR>


"graph view
exmap localgraph obcommand graph:open-local
noremap <Space>gg :localgraph<CR>
exmap graph obcommand graph:open
noremap <Space>gG :graph<CR>

"Super o
nmap <Space>o i<Esc>O<Esc>o


" Delete
    " soft delete keeping the line empty
    map ds 0D
    " delete all text

    map dA gg0dG


"relative 
set number relativenumber



"wraping toggle
nnoremap <Space>W :set wrap!<cr>

"jump and center

nnoremap n nzz
nnoremap N Nzz
nnoremap G Gzz
nnoremap { {zz
nnoremap } }zz
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-i> <C-i>zz
nnoremap <C-o> <C-o>zz
nnoremap [m [mzz
nnoremap [M [Mzz
nnoremap ]m ]mzz
nnoremap ]M ]Mzz
nnoremap gl glzz
nnoremap gL gLzz
nnoremap [[ [[zz
nnoremap ]] ]]zz

