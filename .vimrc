"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: С��
" Email: gzxabcdefg@163.com
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ͨ������
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700				"VIM��¼����ʷ������
set helplang=cn				"VIM�İ���������

" ���ļ��Զ���⹦��
filetype plugin on
filetype indent on

" ���ļ����ⲿ����ʱ�����Զ������ļ�
set autoread

" ����һ��map leaderʹ�������ø�����������
let mapleader = ","
let g:mapleader = ","

" ���ٱ���
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM����
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ��Ļ����ʱ�ڹ�����·�����7��
set so=7

" ������ģʽ��ʹ�� Tab �Զ���ȫ��ʱ�򣬽���ȫ����ʹ��һ��Ư���ĵ��в˵���ʽ��ʾ����
set wildmenu

" ʼ�������½���ʾ״̬��
set ruler

" ���������и߶�
set cmdheight=2

" ��������δ������޸�ʱ�л�������
set hidden 

" �����˸����ģʽ��eolɾ����һ�У�startɾ���˴β���֮ǰ�����ݣ�indentɾ���Զ�����������
set backspace=eol,start,indent

" �����۷���һ�л���һ��ʱ����Ŀ�ݼ������ҷ����, h��l��
set whichwrap+=<,>,h,l

" ����ʱ���Դ�Сд
set ignorecase
" ����ʱ�ؼ��ʳ���һ��������ĸʱ�����ִ�Сд
set smartcase
" ��������������
set hlsearch
" ������������
set incsearch
" ���õ����к�ʱ���ػ�(ʹ�����ٶȸ���)
set lazyredraw
" ����ʱ��magic���ã��鿴:h magic
set magic

" ������ʾƥ�������
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" ��ֹ������
set noerrorbells
set novisualbell
" ��������
set t_vb=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ��ɫ������
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" ��������
set gfn=Monospace\ 10
set shell=/bin/bash

" ������ɫģʽ������ɫ
colorscheme zellner
set background=dark

" ����Ĭ�����к�
set nonu

" �����ڲ�����
set encoding=utf-8
" �ն���ʾ����
set termencoding=gb18030
" ���ÿ�ʶ����ļ�����
set fileencodings=gb18030,utf-8,cp936,ucs-bom,big5,euc-jp,euc-kr,latin1
try
    lang en_US
catch
endtry

" Ĭ�ϵ��ļ�����
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => �ļ������ݺ�undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" �رձ���
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => �ı����Ʊ��������
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" �Զ�����ÿһ��ʹ�õĿհ���Ŀ
set shiftwidth=4
" �����ļ���tab��ʾ�Ŀո���
set tabstop=4
" ����linebreak��ʹVIM���ļ��пհ׵ĵط�����
set linebreak
" �����ļ���ȣ�0��ʾ������
set textwidth=0

" �����Զ�����
set autoindent
" �������еĲ����Զ����� 
set si
" ���ڵ�һ�е��ı��ỻ����ʾ
set wrap


""""""""""""""""""""""""""""""
" => Visualģʽ���
""""""""""""""""""""""""""""""
" NOTICE: Really useful!

" ��visualģʽ����*��#����ҵ�ǰѡ�еĲ���
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" From an idea by Michael Naumann
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" �ڴ���֮���ƶ�ʱ�����ô�ӳ��
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" ʹ�ü�ͷ����:bn :bp�����ļ�֮���ƶ�
map <right> :bn<cr>
map <left> :bp<cr>

" tab��ݼ�
map <leader>tn :tabnew! %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

""""""""""""""""""""""""""""""
" => ״̬��
""""""""""""""""""""""""""""""
" ����״̬��������ʾ
set laststatus=2

" ��ȡgit��֧
function! GitBranch()
    try
        let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
    catch
        return ''
    endtry

    if branch != ''
        return '   Git Branch: ' . substitute(branch, '\n', '', 'g')
    en

    return ''
endfunction

" ��ȡ��ǰĿ¼
function! CurDir()
    return substitute(getcwd(), '/Users/amir/', "~/", "g")
endfunction

" �Ƿ�ճ��ģʽ
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" ״̬����ʽ
set statusline=\ %F%m%r%h\ %w\ \ Line:\ %l/%L

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => �༭ģʽӳ��
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ӳ��0Ϊ^
map 0 ^

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ����pathogen���
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()

""""""""""""""""""""""""""""""
" => taglist plugin
""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
map <silent> <leader>tl :TlistToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


""""""""""""""""""""""""""""""
" => css ����
""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.less set filetype=less
autocmd FileType css,less,scss setlocal expandtab smarttab shiftwidth=2 softtabstop=2


""""""""""""""""""""""""""""""
" => json ����
""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.json set filetype=json
autocmd FileType json setlocal expandtab smarttab shiftwidth=2 softtabstop=2



""""""""""""""""""""""""""""""
" => Python����
""""""""""""""""""""""""""""""
" ʹflake8���
let python_highlight_all = 1
let g:flake8_builtins="_,apply"
let g:flake8_ignore="E501,W293"
au BufWritePost *.py call Flake8()

au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 
au FileType python setlocal expandtab smarttab shiftwidth=4 softtabstop=4

" ɾ������հף���python������
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi


"""""""""""""""""""""""""""""""
" => Html����
"""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.htm,*.html set filetype=html
au FileType html setlocal expandtab smarttab shiftwidth=2 softtabstop=2


"""""""""""""""""""""""""""""""
" => xml����
"""""""""""""""""""""""""""""""
au FileType xml setlocal expandtab smarttab shiftwidth=2 softtabstop=2


""""""""""""""""""""""""""""""
" => MRU��������Լ�¼�������ʷ
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH

""""""""""""""""""""""""""""""
" => �Զ��������ݼ�
""""""""""""""""""""""""""""""
map <leader>cl i\\color{}{}<esc>2hi


set tags=tags;../tags;../../tags;../../../tags;../../../../tags;
