" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
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

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

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
syntax enable
syntax on

colorscheme emacs
"set background=dark
"hi clear
"if exists("syntax_on")
"    syntax reset
"endif

"set guifont=Consolas:h11:cANSI
set guifont=Monospace\ Italic\ 11
"set lines=30 columns=120
set number
"set encoding=cp936
set fileencodings=gbk,cp936,utf-8
set nocp
set cindent

"for taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Compact_Format=1
"for winmanager
let g:winManagerWindowLayout='TagList'
nmap wm :WMToggle<cr>

":set cscopequickfix=s-,c-,d-,i-,t-,e-

"for new-omni-completion
filetype plugin indent on
set completeopt=longest,menu
"for supertab
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

"set mouse avaliable
set mouse=a
"set update time to 1ms
set updatetime=1

"minibufferExploer
let g:miniBufExplMapWindowVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1

"TagHighlight settings
if ! exists('g:TagHighlightSettings')
	let g:TagHighlightSettings = {}
endif
let g:TagHighlightSettings['TagFileName'] = 'tags'
let g:TagHighlightSettings['CtagsExecutable'] = 'ctags'
let g:TagHighlightSettings['ForcePythonVariant'] = 'if_pyth'
let g:TagHighlightSettings['PathToPython'] = '/bin/python'

"
"key mappings for each plugin
"
"for cscope
map <F2> "zyiw:exe ":cs find s ".@z.""<CR>
map <F3> "zyiw:exe ":cs find c ".@z.""<CR>
map <F4> "zyiw:exe ":cs find g arad_pp_".@z.""<CR>

"for buffers switch
"map <F12> :bnext<CR>
"map <F11> :bprev<CR>

"for split
nmap <F5> :split<cr>

"tab instead 
set tabstop=4
set shiftwidth=4
set expandtab

"share clipboard with windows
set clipboard+=unnamed

set nobackup
set virtualedit=all
"set cursorline              " ͻ����ʾ��ǰ��
set ruler                   " ��״̬�����
"set autochdir               " �Զ��л���ǰĿ¼Ϊ��ǰ�ļ����ڵ�Ŀ¼
set ignorecase smartcase    " ����ʱ���Դ�Сд��������һ�������ϴ�д��ĸʱ�Ա��ֶԴ�Сд����
set nowrapscan              " ��ֹ���������ļ�����ʱ��������
set incsearch               " ������������ʱ����ʾ�������
set hlsearch                " ����ʱ������ʾ���ҵ����ı�
set guioptions-=T           " ���ع�����
set guioptions-=m           " ���ز˵���
set smartindent             " ��������ʱʹ�������Զ�����
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\                " ������״̬����ʾ����Ϣ

"-----------------------------------------------------------------
" plugin - NERD_commenter.vim   ע�ʹ����õģ�
" [count],cc �������count���������ע��(7,cc)
" [count],cu �������count������ȡ��ע��(7,cu)
" [count],cm �������count�г�����ӿ�ע��(7,cm)
" ,cA ����β���� /* */,���ҽ������ģʽ�� ��������дע�͡�
" ע��count������ѡ������Ĭ��Ϊѡ���л�ǰ��
"-----------------------------------------------------------------
let NERDSpaceDelims=1       " ��ע�ͷ������֮����һ���ո�
let NERDCompactSexyComs=1   " ����ע��ʱ���Ӹ��ÿ�

"-----------------------------------------------------------------
" plugin - DoxygenToolkit.vim  ��ע�������ĵ��������ܹ��������ɺ�����׼ע��
"-----------------------------------------------------------------
let g:DoxygenToolkit_authorName="luantu@vip.qq.com"
let g:DoxygenToolkit_briefTag_funcName="yes"
map <leader>da :DoxAuthor<CR>
map <leader>df :Dox<CR>
map <leader>db :DoxBlock<CR>
map <leader>dc a /*  */<LEFT><LEFT><LEFT>
set pastetoggle=<F12>

set helplang=cn 
let g:winManagerWindowLayout = "TagList|FileExplorer,BufExplorer"
let g:winManagerWidth = 50
