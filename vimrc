" vim:foldmethod=marker
filetype plugin on
syntax on

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let mapleader=" "
let g:coc_global_extensions = [
      \ "coc-explorer",
			\ "coc-snippets",
      \ "coc-marketplace",
      \ "coc-git",
      \ "coc-lists",
      \ "coc-json",
      \ "coc-tsserver",
      \ "coc-go",
      \]

set encoding=utf-8
set nobackup
set nowritebackup
set noswapfile
set updatetime=300
set shortmess+=c
set signcolumn=number
set number
set hidden
set magic
set relativenumber
set hidden
set nowrap
set modeline
set noexpandtab
set incsearch
set wildmenu
set mouse=a

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/GV.vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

call plug#end()

function s:dim_colorscheme_overrides()
	highlight EndOfBuffer ctermfg=0
endfunction

autocmd ColorScheme dim call <SID>dim_colorscheme_overrides()

colorscheme dim

function! s:coc_setup() abort "{{{
	" This configuration is taken from coc github page
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gr <Plug>(coc-references)
	nmap <silent> <leader>r <Plug>(coc-rename)
	xmap <silent> <leader>a <Plug>(coc-codeaction-selected)
	nmap <silent> <leader>a <Plug>(coc-codeaction-selected)
	nnoremap <silent> gh :call <SID>show_documentation()<CR>
	nnoremap <silent> <leader>l :CocList<cr>
	nnoremap <silent> <leader>b :CocCommand explorer<cr>
	inoremap <silent><expr> <c-@> coc#refresh()

	xmap if <Plug>(coc-funcobj-i)
	omap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap af <Plug>(coc-funcobj-a)
	xmap ic <Plug>(coc-classobj-i)
	omap ic <Plug>(coc-classobj-i)
	xmap ac <Plug>(coc-classobj-a)
	omap ac <Plug>(coc-classobj-a)

	if exists('*complete_info')
		inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
		inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	command! -nargs=0 Format :call CocAction('format')
	command! -nargs=? Fold :call CocAction('fold', <f-args>)
	command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')
endfunction "}}}

call <sid>coc_setup()
