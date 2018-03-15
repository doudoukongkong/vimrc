"vim 几种模式
"Normal Mode 一般的普通模式，默认进入vim之后，就处于这种模式
"Visual Mode 可视模式，在这种模式下选定一些字符、行、多列。在普通模式下，可以按v进入
"Insert Mode 插入模式，其实就是指处在编辑输入的状态。普通模式下，可以按i进入
"Select Mode 选择模式。用鼠标拖选区域的时候，就进入了选择模式。和可视模式不同的是，在这个模式下，选择完了高亮区域后，敲任何按键就直接输入并替换选择的文本了。和windows下的编辑器选定编辑的效果一致。普通模式下，可以按gh进入
"Command-Line/Ex Mode  命令行模式和Ex模式。两者略有不同，普通模式下按冒号(:)进入Command-Line模式，可以输入各种命令，使用vim的各种强大功能。普通模式下按Q进入Ex模式，其实就是多行的Command-Line模式

"map 命令组合
"同Vim下的其他命令一样，命令的名字往往由好几段组成。前缀作为命令本身的修饰符，微调命令的效果
"对于map而言，可能有这么几种前缀
"nore 表示非递归。递归的映射。其实很好理解，也就是如果键a被映射成了b，c又被映射成了a，如果映射是递归的，那么c就被映射成了b。
"n 表示在普通模式下生效
"v 表示在可视模式下生效
"i 表示在插入模式下生效
"c 表示在命令行模式下生效
":map {lhs} {rhs} 其含义是，在:map作用的模式中把键系列 {lhs} 映射为 {rhs}，{rhs}可进行映射扫描，也就是可递归映射
":unmap是对应取消:map绑定的｛lhs｝，作用模式相同
":mapclear时对应取消所有:map绑定的，慎用！
"<k0> - <k9> 小键盘 0 到 9
"<S-...> Shift＋键
"<C-...> Control＋键
"<M-...> Alt＋键 或 meta＋键
"<A-...> 同 <M-...>
"<Esc> Escape 键
"<Up> 光标上移键
"<Space> 插入空格
"<Tab> 插入Tab
"<CR> 等于<Enter>
"



"1.按F5可以直接编译并执行C、C++、java代码以及执行shell脚本，按“F8”可进行C、C++代码的调试
"2.自动插入文件头，新建C、C++源文件时自动插入表头：包括文件名、作者、联系方式、建立时间等，读者可根据需求自行更改
"3.映射“Ctrl + A”为全选并复制快捷键，方便复制代码
"4.按“F3”可以直接消除代码中的空行
"5.“F2”可列出当前目录文件，打开树状文件目录
"6.支持鼠标选择、方向键移动
"7.代码高亮，自动缩进，显示行号，显示状态行
"8.按“Ctrl + P”可自动补全
"9. []、{}、()、""、' '等都自动补全   ---
"如果需要{}做函数形式的补全（右括号自动换行，加一个空行，光标定位到空行，可以看下面的修改提示）
"10.使用YouCompleteMe提供C++的自动补全提示
"
set nocompatible "required  设置vi非兼容模式
filetype off     "required  文件类型检查关闭

"安装ctags
"apt-get install ctags    
"ctags根据代码产生索引文件，支持ava, c, c++, python, perl, php, ruby, scheme, tcl, vim, yacc, bash/kron shell/zsh, cobol, awk, asp, lisp, pascal等等
"光标定位到某个函数或者变量，按ctrl+]就可以跳转到定义,然后使用ctrl+o或者ctrl+t。可以连续选项连续返回
"在vim中执行 :TlistToggle，在被配置中已替代为:TagbarToggle, 会在vim中出现宏、函数、变量列表。按ctrl-w再按w，可以连续在左右窗口切换

"安装cscope
"apt-get install cscope
"ctags 利用tag文件，跳转到标签定义的地方。但如果想查找函数在哪里被调用，或者标签在哪些地方出现过，ctags,就有些无能为力了。这里需要使用更为强大的cscope

"cscope 使用
"为项目代码生成一个cscope数据库
"在项目根目录运行命令：
"cscope -Rbq
"这个命令会生成三个文件: cscope.out, cscope.in.out,
"cscope.po.out。其中cscope.out是基本的索引符号，后两个文件是"-q"选项生成的，可以加速cscope的索引速度。
"在缺省情况下，cscope在生成数据库后就会进入它自己的查询界面，我们一般不用这个界面，所以使用了'-b'选项。如果你已经进入了这个界面，按Ctrl-D退出
"Cscope在生成数据库中，在你的项目目录中未找到的头文件，会自动到/usr/include目录中查找。如果你想阻止它这样做，使用"-k"选项。
"Cscope缺省只解析C文件(.c和.h)、lex文件(.l)和yacc文件(.y)，虽然它也可以支持C++以及Java，但它在扫描目录时会跳过C++及Java后缀的文件。如果你希望cscope解析C++或Java文件，需要把这些文件的名字和路径保存在一个名为cscope.files的文件。当cscope发现在当前目录中存在cscope.files时，就会为cscope.files中列出的所有文件生成索引数据库。通常我们使用find来生成cscope.files文件
"cd 项目目录/src/
"find . –type f > cscope.files   
"cscope -bq
"
"这样会把项目目录下的所有普通文件都加入到cscope.files,
"这样cscope会解析该目录下的每一个文件。上面的cscope命令并没有使用"-R"参数递归查找子目录，因为在cscope.files中已经包含了子目录中的文件。 
"
"注意：find命令输出的文件以相对路径表示，所以cscope.out的索引也相对于当前路径。如果你要在其它路径中使用当前的cscope.out，需要使用下面介绍的-P选项。
"
"Cscope只在第一次解析时扫描全部文件，以后再调用cscope，它只扫描那些改动过的文件，这大大提高了cscope生成索引的速度
"
" 下表中列出了cscope的常用选项：

"    -R: 在生成索引文件时，搜索子目录树中的代码
"    -b: 只生成索引文件，不进入cscope的界面
"    -q: 生成cscope.in.out和cscope.po.out文件，加快cscope的索引速度
"    -k: 在生成索引文件时，不搜索/usr/include目录
"    -i: 如果保存文件列表的文件名不是cscope.files时，需要加此选项告诉cscope到哪儿去找源文件列表。可以使用"-"，表示由标准输入获得文件列表。
"    -Idir: 在-I选项指出的目录中查找头文件
"    -u: 扫描所有文件，重新生成交叉索引文件
"    -C: 在搜索时忽略大小写
"    -Ppath: 在以相对路径表示的文件前加上的path，这样，你不用切换到你数据库文件所在的目录也可以使用它了。

"要在vim中使用cscope的功能，需要在编译vim时选择"+cscope"。vim的cscope接口先会调用cscope的命令行接口，然后分析其输出结果找到匹配处显示给用户
"在vim中使用cscope非常简单，首先调用"cscope add"命令添加一个cscope数据库，然后就可以调用"cscope find"命令进行查找了。vim支持8种cscope的查询功能，如下
"	 s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
"    g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
"    d: 查找本函数调用的函数
"    c: 查找调用本函数的函数
"    t: 查找指定的字符串
"    e: 查找egrep模式，相当于egrep功能，但查找速度快多了
"    f: 查找并打开文件，类似vim的find功能
"    i: 查找包含本文件的文件

"例如，我们想在vim 7.0的源代码中查找调用do_cscope()函数的函数，我们可以输入：":cs find c do_cscope"，回车后发现没有找到匹配的功能，可能并没有函数调用do_cscope()。我们再输入":cs find s do_cscope"，查找这个C符号出现的位置，现在vim列出了这个符号出现的所有位置



" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()



" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here') 
"
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'             "Code Folding  代码折叠
Plugin 'vim-scripts/indentpython.vim'     "auto indent python  自动缩进
Plugin 'Valloric/YouCompleteMe'           "Code complete 支持代码补全，跳转
"YouCompleteMe是一个比较新Vim代码补全插件，可以基于clang为C/C+＋代码提供代码提示。它安装配置简单，Bug很少。对C/C++来说youcompleteme现在应该是最好选择，借助clang的强大功能，补全效率和准确性极高，而且可以模糊匹配（见下面的demo）。不管你的C++代码用什么怪异的写法，只要能编译通过，都能补全，即使是C++11的lambda和auto都没有障碍，比codeblock这些根据tagindex补全的IDE都要强大, YCM需要最新的vim(7.3.584)的支持
Plugin 'davidhalter/jedi'                 "补全Python
Plugin 'scrooloose/syntastic'             "syntax check  语法检查
let g:syntastic_ignore_files=["*.*\py$"]  "让systastic忽略python文件
Plugin 'nvie/vim-flake8'                  "PEP8 check
Plugin 'jnurmine/Zenburn'                 "Color     
Plugin 'altercation/vim-colors-solarized' "Color
Plugin 'scrooloose/nerdtree'              "file dir       文件目录
Plugin 'tpope/vim-fugitive'               "git interface  
Plugin 'jistr/vim-nerdtree-tabs'          "tab             
Plugin 'kien/ctrlp.vim'                   "super sourch   超级模糊搜索
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}  "status line
Plugin 'majutsushi/tagbar'                "tag 标签列表， taglist的替代
"Add all your plugins here (note older version of Vundle used Bundle instead
"of Plugin)

"All of your Plugins must be added before the following line"
call vundle#end()  "required
filetype plugin indent on "required

set splitbelow
set splitright

"split navigations  分割窗口导航
nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Ctrl-j 切换到下方的分割窗口
"Ctrl-k 切换到上方的分割窗口
"Ctrl-l 切换到右侧的分割窗口
"Ctrl-h 切换到右侧的分割窗口
"换句话说， 按Ctrl+Vim 的标准移动键就可以切换到指定窗口
"nnoremap
"是将一个组合快捷键映射成另一个快捷键。一开始的n，指的是在vim的正常模式下(Normal
"Mode), 而不是可视模式下重新映射。

"Enable folding . 开启對类或者方法进行折叠
set foldmethod=indent
set foldlevel=99
"Enable folding with the spachbar
nnoremap <space> za
let g:SimpylFold_docstring_preview=1

"新建或读取.py文件时设置
au BufNewFile,BufRead *.py   
    \ set tabstop=4  |
    \ set softtabstop=4  |
    \ set shiftwidth=4   |
    \ set textwidth=79   |
    \ set expandtab  |    
    \ set autoindent |
    \ set fileformat=unix

"新建或读取.c,*cpp文件时设置
au BufNewFile,BufRead *.c,*cpp
    \ set tabstop=4   |
    \ set shiftwidth=4 |
    \ set autoindent   |
    \ set fileformat=unix 

"新建或读取时设置
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2  

"将多余的空白字符标示出来，很可能会将它们变成红色突出
"Flagging Unnecessary Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"设置编码
set encoding=utf-8

"map是一个映射指定，将常用较长的命令映射到新的功能键
let mapleader=',' "mapleader对所有map映射命令有效，将产生<leader>替换成mapleader变量的值, 默认值是\

"YouCompleteMe 通过这个cm_global_ycm_extra_conf来获得补全规则，可以如下指定，也可以每次放置在工作目录
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' "语义补全配置文件,进行代码补全时需要查找该文件 
let g:ycm_autoclose_preview_window_after_completion=1  "自动补全
let g:ycm_collect_identifiers_from_tag_files=1  "使用ctags生成的tags文件
let g:ycm_use_ultisnips_completer=1 "默认为1, 进行确认
let g:ycm_seed_identifiers_with_syntax=1 "程序语言关键字补全

let g:ycm_python_binary_path='python'

"空格+g 跳转到定义
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR> 
"空格+g+l 跳转到声明
map <leader>gl :YcmCompleter GoToDeclaration<CR>
"空格+g+f 跳转到定义
map <leader>gf :YcmCompleter GoToDefinition<CR>

"空格tb 标签函数列表
map <leader>tb :TagbarToggle<CR>   

map <M-F4> :tabnew<CR>

"python 虚拟环境
"python << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    activate_this = os.path.join(project_base_dir, "bin/activate_this.py")
"    execfile(activate_this, dict(__file__=activate_this))
"EOF


let python_highlight_all=1
syntax on


if has('gui_running')
    set background=dark
    colorscheme solarized
else 
    colorscheme zenburn
endif

call togglebg#map("<F5>")
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree


set ts=4
set expandtab

set nu   "显示行号

"NERDTree快捷键
nmap <F2> :NERDTreeToggle <CR>   
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"自动补全插件"
"filetype plugin on
"let g:pydiction_location='~/.vim/after/ftplugin/pydiction/complete-dict'


""""""""""""""""""""""""""""""""""""""""""""
"Quickly Run, 编译运行
""""""""""""""""""""""""""""""""""""""""""""
map <F5> :call CompileRunGcc()<CR>

fun! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    endif
endfunc

"C,C++的调试

map <F8> :call Rungdb()<CR>

func! Rungdb()

    exec "w"

    exec "!g++ % -g -o %<"

    exec "!gdb ./%<"

endfunc



"新建.c,.h,.sh,.java文件，自动插入文件头 

autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 

""定义函数SetTitle，自动插入文件头 

func SetTitle() 

    "如果文件类型为.sh文件 

    if &filetype == 'sh' 

        call setline(1,"\#########################################################################") 

        call append(line("."), "\# File Name: ".expand("%")) 

        call append(line(".")+1, "\# Author: wmc") 

        call append(line(".")+2, "\# mail: 1047453361@qq.com") 

        "原来的时间形式比较复杂，不喜欢，改变一下

        "call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+3, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))

        call append(line(".")+4, "\#########################################################################") 

        call append(line(".")+5, "\#!/bin/bash") 

        call append(line(".")+6, "") 

    else 

        call setline(1, "/*************************************************************************") 

        call append(line("."), "    > File Name: ".expand("%")) 

        call append(line(".")+1, "    > Author: wmc") 

        call append(line(".")+2, "    > Mail: 1941767125@qq.com ") 

        " 同样的 改变时间格式
        "call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+3, "    > Created Time: ".strftime("%Y-%m-%d",localtime()))

        call append(line(".")+4, " ************************************************************************/") 

        call append(line(".")+5, "")

    endif

    if &filetype == 'cpp'

        call append(line(".")+6, "#include <iostream>")

        call append(line(".")+7, "using namespace std;")

        call append(line(".")+8, "")

    endif

    if &filetype == 'c'

        call append(line(".")+6, "#include <stdio.h>")

        call append(line(".")+7, "")

    endif

    "新建文件后，自动定位到文件末尾

    autocmd BufNewFile * normal G

endfunc 

" Suzzz：  模仿上面，新建python文件时，添加文件头

autocmd BufNewFile *py exec ":call SetPythonTitle()"

func SetPythonTitle()
    call setline(1,"#!/usr/bin/env python")
    call append( line("."),"#-*- coding: utf-8 -*-" )
    call append(line(".")+1," ")
    call append(line(".")+2, "\# File Name: ".expand("%")) 
    call append(line(".")+3, "\# Author: wmc") 
    call append(line(".")+4, "\# mail: 1941767125@qq.com") 
    call append(line(".")+5, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))    
endfunc


"快捷方式命令
nmap <leader>w :w!<CR>
nmap <leader>f :find<CR>



" 映射全选+复制 ctrl+a
map <C-A> ggVGY

map! <C-A> <Esc>ggVGY

map <F12> gg=G

" 选中状态下 Ctrl+c 复制

vmap <C-c> "+y

"去空行  

nnoremap <F4> :g/^\s*$/d<CR> 

"比较文件  

nnoremap <C-F4> :vert diffsplit 
"新建标签  

map <M-F4> :tabnew<CR>  

"列出当前目录文件  
"map <F3> :tabnew .<CR>  




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""实用设置

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 设置当文件被改动时自动载入

set autoread

" quickfix模式

autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

"代码补全 

set completeopt=preview,menu 

"允许插件  

filetype plugin on

"共享剪贴板  

set clipboard+=unnamed 

"make 运行

:set makeprg=g++\ -Wall\ \ %


filetype plugin indent on 

"打开文件类型检测, 加了这句才可以用智能补全

set completeopt=longest,menu


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" CTags的设定  

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags=./tags



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR> 
