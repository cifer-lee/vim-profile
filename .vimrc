" vimrc file used by Cifer, based on the *vimrc_example.vim*
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set nu      " show line number
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set showmatch		" Show matching brackets.
set smartcase		" Do smart case matching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" expand tab to 4 spaces
set expandtab
set tabstop=4

" autoindent 4 spaces too
set shiftwidth=4

" make the *case* lable align with *swith* in swith{ case: break } block of c
" language
set cino=:0

" you should have installed the 'clue' color scheme, i.e. ~/.vim/colors/clue.vim
colorscheme solarized

"
" cscope configuration
"
" set key binding
"
" s: Find this C symbol 
nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR> 
" g: Find this definition 
nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR> 
" d: Find functions called by this function 
nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR> 
" c: Find functions calling this function 
nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR> 
" t: Find this text string 
nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR> 
" e: Find this egrep pattern 
nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR> 
" f: Find this file 
nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR> 
" i: Find files #including this file 
nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR> 
"
" auto load cscope db
if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  "set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
endif
