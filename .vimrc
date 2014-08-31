"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: 小新
" Email: gzxabcdefg@163.com
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 通用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=700				"VIM记录的历史的行数
set helplang=cn				"VIM的帮助的语言

" 打开文件自动检测功能
filetype plugin on
filetype indent on

" 当文件从外部更改时可以自动更新文件
set autoread

" 设置一个map leader使可以作用更多的命令组合
let mapleader = ","
let g:mapleader = ","

" 快速保存
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM界面
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 屏幕滚动时在光标上下方保留7行
set so=7

" 在命令模式下使用 Tab 自动补全的时候，将补全内容使用一个漂亮的单行菜单形式显示出来
set wildmenu

" 始终在右下角显示状态行
set ruler

" 设置命令行高度
set cmdheight=2

" 允许在有未保存的修改时切换缓冲区
set hidden 

" 设置退格键的模式：eol删除上一行，start删除此次插入之前的内容，indent删除自动缩进的内容
set backspace=eol,start,indent

" 设置折返上一行或下一行时允许的快捷键：左右方向键, h和l键
set whichwrap+=<,>,h,l

" 搜索时忽略大小写
set ignorecase
" 搜索时关键词出现一个大字字母时才区分大小写
set smartcase
" 高亮搜索的内容
set hlsearch
" 设置增量查找
set incsearch
" 设置当运行宏时不重绘(使运行速度更快)
set lazyredraw
" 查找时的magic设置，查看:h magic
set magic

" 高亮显示匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" 禁止报警声
set noerrorbells
set novisualbell
" 可视铃声
set t_vb=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 颜色和字体
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" 设置字体
set gfn=Monospace\ 10
set shell=/bin/bash

" 设置配色模式，背景色
colorscheme zellner
set background=dark

" 设置默认无行号
set nonu

" 设置内部编码
set encoding=utf-8
" 终端显示编码
set termencoding=gb18030
" 设置可识别的文件编码
set fileencodings=utf-8,gb18030,cp936,ucs-bom,big5,euc-jp,euc-kr,latin1
try
    lang en_US
catch
endtry

" 默认的文件类型
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 文件、备份和undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 关闭备份
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 文本、制表符和缩进
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自动缩进每一步使用的空白数目
set shiftwidth=4
" 设置文件中tab表示的空格数
set tabstop=4
" 设置linebreak，使VIM在文件中空白的地方折行
set linebreak
" 设置文件宽度，0表示不限制
set textwidth=0

" 设置自动缩进
set autoindent
" 开户新行的采用自动缩进 
set si
" 大于的一行的文本会换行显示
set wrap


""""""""""""""""""""""""""""""
" => Visual模式相关
""""""""""""""""""""""""""""""
" NOTICE: Really useful!

" 在visual模式按下*或#会查找当前选中的部分
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

" 在窗口之间移动时，采用此映射
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" 使用箭头代替:bn :bp，在文件之间移动
map <right> :bn<cr>
map <left> :bp<cr>

" tab快捷键
map <leader>tn :tabnew! %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

""""""""""""""""""""""""""""""
" => 状态行
""""""""""""""""""""""""""""""
" 设置状态行总是显示
set laststatus=2

" 获取git分支
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

" 获取当前目录
function! CurDir()
    return substitute(getcwd(), '/Users/amir/', "~/", "g")
endfunction

" 是否粘贴模式
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" 状态栏格式
set statusline=\ %F%m%r%h\ %w\ \ Line:\ %l/%L

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 编辑模式映射
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 映射0为^
map 0 ^

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 启用pathogen插件
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
" => css 部分
""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.less set filetype=less
autocmd BufNewFile,BufRead *.scss set filetype=scss
autocmd FileType css,less,scss setlocal expandtab smarttab shiftwidth=2 softtabstop=2


""""""""""""""""""""""""""""""
" => json 部分
""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.json set filetype=json
autocmd FileType json setlocal expandtab smarttab shiftwidth=2 softtabstop=2



""""""""""""""""""""""""""""""
" => Python部分
""""""""""""""""""""""""""""""
" 使flake8插件
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

" 删除多余空白，在python中有用
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.js set filetype=javascript
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi
au FileType python setlocal expandtab smarttab shiftwidth=4 softtabstop=4


"""""""""""""""""""""""""""""""
" => Html部分
"""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.htm,*.html set filetype=html
au FileType html setlocal expandtab smarttab shiftwidth=2 softtabstop=2


"""""""""""""""""""""""""""""""
" => xml部分
"""""""""""""""""""""""""""""""
au FileType xml setlocal expandtab smarttab shiftwidth=2 softtabstop=2


""""""""""""""""""""""""""""""
" => MRU插件，可以记录最近打开历史
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH

""""""""""""""""""""""""""""""
" => 自定义输入快捷键
""""""""""""""""""""""""""""""
" map <leader>cl i\\color{}{}<esc>2hi
map <leader>il i\\(\\)<esc>2hi


set tags=tags;../tags;../../tags;../../../tags;../../../../tags;
