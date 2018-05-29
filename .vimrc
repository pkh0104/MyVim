
set bs=indent,eol,start
set ru
set sc
set ts=4
set sw=4
set sts=4
au Bufenter *.\(c\|cpp\|cc\|h\|hpp\) set et
set wrap
set noai
set incsearch
set hls
set scs
if has("gui_running")
    set lines=50
    set co=125
endif
set report=0
set ls=2
set background=dark
set ruler 
filet plugin indent on
syntax on
set ai
set si
set wmnu

let g:explVertical=1
let g:explSplitRight=1
let g:explStartRight=1
let g:explWinSize=20

nmap <F2> :bw<CR>
nmap <F3> :bp<CR>
nmap <F4> :bn<CR>

nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nmap <F5> :cs find g <C-R>=expand("<cword>") <CR><CR>
nmap <F6> :cs find c <C-R>=expand("<cword>") <CR><CR>
nmap <F7> :cs find s <C-R>=expand("<cword>") <CR><CR>
map <F8> <Plug>HexManager
map <PageUp> <C-U><C-U>
map <PageDown> <C-D><C-D>
nnoremap <F9> :NERDTree<CR>
nnoremap <F10> :TlistToggle<CR>
nnoremap <F12> :SrcExplToggle<CR>
set lz
set lpl
set ffs=unix,dos,mac
set completeopt=menu

filetype plugin on
function! InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col-1]!~'\k'
		return "\<TAB>"
	else
		if pumvisible()
			return "\<C-N>"
		else
			return "\<C-N>\<C-P>"
		end
	endif
endfunction
au BufReadPost *  
			\ if line("'\"") > 0 && line("'\"") <= line("$") |  
			\   exe "norm g`\"" |  
			\ endif

inoremap <tab> <c-r>=InsertTabWrapper()<cr>

hi Pmenu ctermbg=blue
hi PmenuSel ctermbg=yellow ctermfg=black
hi PmenuSbar ctermbg=blue


set tags=./tags
set tags+=$HOME/Study/OpenGL/SimpleCube/tags
set tags+=$HOME/Projects/application/tags
set tags+=$HOME/Projects/pgstools_v30/tags
set tags+=$HOME/Projects/hkmc_gen6_pgs_lib/tags
"set tags+=$HOME/build-coconut/vendor/nvidia/drive-t186ref-linux/samples/opengles2/tags
"set tags+=$HOME/build-coconut/vendor/nvidia/drive-t186ref-linux/samples/nvmedia/ipp_yuv_gen2_pgs/tags
"set tags+=$HOME/build-coconut/vendor/nvidia/drive-t186ref-linux/samples/nvmedia/pgslib/tags
"set tags+=$HOME/build-coconut/vendor/nvidia/drive-t186ref-linux/samples/nvmedia/pgslib_180406/tags

" ==============================================================================
" Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Let Vundle manage itself.
Plugin 'VundleVim/Vundle.vim'
" Plugins
Plugin 'The-NERD-tree'
Plugin 'taglist-plus'
Plugin 'neocomplcache'
Plugin 'SrcExpl'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
call vundle#end()            " required
filetype plugin indent on    " required
" ==============================================================================

let NERDTreeWinPos = "left"

filetype on
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
"let Tlist_Inc_Winwidth = 0
"let Tlist_Exit_OnlyWindow = 0
"let Tlist_Auto_Open = 0
let Tlist_Use_Right_Window = 1

let g:SrcExpl_winHeight = 8
let g:SrcExpl_refreshTime = 100
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_pluginList = [
		\"__Tag_List__",
		\"NERD_tree_1"
	\]
let g:SrcExpl_searchLocalDef = 1
let g:SrcExpl_isUpdateTags = 0
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."
"let g:SrcExpl_prevDefKey = "<F3>"
"let g:SrcExpl_nextDefKey = "<F4>"
nnoremap <C-I> <C-W>j:call g:SrcExpl_Jump()<CR>
nnoremap <C-O> :call g:SrcExpl_GoBack()<CR>

set term=xterm-256color
set t_Co=256
let g:neocomplcache_enable_at_startup = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='light'
set laststatus=2

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlpl_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svm)$',
	\ 'file': '\v\.(S|o|so)$',
	\ 'link': 'some_bad_symbolic_links',
	\ }

set csto=0
set cst
set nocsverb
if filereadable("./cscope.out")
	cs add cscope.out
else 
	cs add /usr/src/linux/cscope.out
endif
set csverb


" end of file

