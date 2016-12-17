" ====== Package Dependences =====
" ctags

"屏蔽 <esc>键，包括 <c-]> <c-c>
"inoremap <esc> <nop>
"-----------------------------------------------------------------------------
"RULES:
"<leader>o : start the plugin command
"<leader>x : start the file type chagne
"-----------------------------------------------------------------------------

"-----------------------------------------------------------------------------
"< 判断是linux还是windows >
"-----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

"-----------------------------------------------------------------------------
"< 判断是终端还是 Gvim >
"-----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

"=============================================================================
"<< 以下为gvim软件默认配置 >>
"=============================================================================
if (g:iswindows && g:isGUI)
    set nocompatible
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin

    set diffexpr=MyDiff()
    function! MyDiff() " ! to replace by force
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

"=========================== 插件管理 开始 ===========================
"Vundle Github:https://github.com/VundleVim/Vundle.vim
set nocompatible              " required
filetype off                  " required

if (g:iswindows && g:isGUI)
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$VIM/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

" === 插件管理核心库 ===
Plugin 'VundleVim/Vundle.vim'
" 如果你的插件来自github，写在下方，只要作者名/项目名就行了
" Plugin 'tpope/vim-fugitive'
" 如果插件来自 vim-scripts，你直接写插件名就行了
" Plugin 'L9'
" 如使用自己的git库的插件，像下面这样做
" Plugin 'git://git.wincent.com/command-t.git'
" 本地插件
" Plugin 'file:///Users/gmarik/path/to/plugin'
"=========================== 下面放插件配置内容 ======================
"============================ 语法相关 高亮/检查 =====================
" ============================ 语法通用 =====================
"YouCompleteMe.
Plugin 'Valloric/YouCompleteMe'
Plugin 'othree/html5.vim'
" ============================ 语法补全 =====================
" 自动补全html/xml标签
Plugin 'docunext/closetag.vim'
let g:closetag_html_style=1
"============================ 语法检查 =====================
"多语言语法检查
"Plugin 'scrooloose/syntastic'  " TODO
"" 推荐新手
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" ============================ 语法美化 =====================
" 格式化
Plugin 'maksimr/vim-jsbeautify'
".vimrc
map <leader>ff :call JsBeautify()<cr>
"for js
autocmd FileType javascript noremap <buffer>  <leader>ff :call JsBeautify()<cr>
"for json
autocmd FileType json noremap <buffer> <leader>ff :call JsonBeautify()<cr>
"for jsx
autocmd FileType jsx noremap <buffer> <leader>ff :call JsxBeautify()<cr>
"for html
autocmd FileType html noremap <buffer> <leader>ff :call HtmlBeautify()<cr>
"for css or scss
autocmd FileType css noremap <buffer> <leader>ff :call CSSBeautify()<cr>

" ============================ 色彩主题 ===============================
Plugin 'tomasr/molokai'
"let g:molokai_original = 1
let g:rehash256 = 1

" gruvbox主题
Plugin 'morhetz/gruvbox'
"颜色对比度[soft/medium/hard]
let g:gruvbox_contrast_dark="medium"

" solarized主题
Plugin 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256

" ============================ 编辑 =====================================
" 选中区块
Plugin 'terryma/vim-expand-region'
"map + <Plug>(expand_region_expand)
"map _ <Plug>(expand_region_shrink)
vnoremap m <Plug>(expand_region_expand)
vnoremap M <Plug>(expand_region_shrink)

" 多光标选中编辑
Plugin 'terryma/vim-multiple-cursors'
set selection=inclusive
let g:multi_cursor_use_default_mapping=0
"Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" ctrl + m 开始选择
" ctrl + p 向上取消
" ctrl + x 跳过

" 更改包围的字符
Plugin 'tpope/vim-surround'
" 命令示例:
" origin: "Hello world!"
" cs"' ==> 'Hello world!'
" cs'<q> ==> <q>Hello world!</q>
" To go full circle, press cst" ==> "Hello world!"
" ds" ==> Hello world!
" 光标置于 Hello 上面：
" ysiw] ==> [Hello] world!  (iw is a text object)
" cs]{ ==> { Hello } world! (如果使用 } 则没有空格)
" yssb or yss) ==> ({ Hello } world!)
" ds{ds) ==> Hello world!
" Emphasize hello: ysiw<em> ==> <em>Hello</em>em> world!
" Visual Mode: press V:
" S<p class="important"> ==> just try yourself :)
" The . command will work with ds, cs, and yss if you install `repeat.vim`.

" Emmet 不解释
Plugin 'mattn/emmet-vim'
"let g:user_emmet_install_global = 0
"autocmd FileType html,css EmmetInstall
"上面两行配置是仅在html、css文件中生效
let g:user_emmet_leader_key='<c-y>'
let g:user_emmet_mode='a' "enable functions in which mode

" 快捷注释插件
Plugin 'The-NERD-Commenter'
let NERDShutUp=1
" <leader>cc 注释当前行
" <leader>cn 同上，但是强制嵌套
" <leader>c<space> 切换当前选择的行的注释状态
" <leader>cm Comments the given lines using only one set of multipart delimiters.
" <leader>ci 分别切换选择行的注释状态
" <leader>cs 性感地注释多行
" <leader>cy Same as <leader>cc except that the commented line(s) are yanked first.
" <leader>c$ 注释当前行到行尾
" <leader>cA 在行尾添加注释
" <leader>ca 在可选的注释方式之间切换
" <leader>cu 取消注释当前行或多行

" Provides insert mode auto-completion for quotes, parens, brackets, etc.
Plugin 'raimondi/delimitmate'
"==============================END==============================

"============================MarkdownStart======================
" 更快捷地编辑表格
Plugin 'dhruvasagar/vim-table-mode'
" To start using the plugin in the on-the-fly mode use :TableModeToggle mapped to <Leader>tm by default.
" Enter the first line, delimiting columns by the `|` symbol. The plugin reacts by inserting spaces between the text and the separator if you omit them:
" In the second line (without leaving Insert mode), enter `|` twice. The plugin will write a properly formatted horizontal line:
" When you enter the subsequent lines, the plugin will automatically adjust the formatting to match the text you’re entering every time you press `|`.
" Go on until the table is ready.
" Then you can return to the first line and above it enter `||`.
"
"===============================END==============================

"============================版本管理Git========================
Plugin 'tpope/vim-fugitive'
" :Git   :Gstatus    :Gcommit    :Gpush    :Gpull

Plugin 'airblade/vim-gitgutter'
set updatetime=250

"============================Python=============================
"Plugin 'davidhalter/jedi-vim'
Plugin 'klen/python-mode'
"Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"
"Override run current python file key shortcut to Ctrl-Shift-e
let g:pymode_run_bind = "<C-S-e>"
"Override view python doc key shortcut to Ctrl-Shift-d
let g:pymode_doc_bind = "<C-S-d>"
"documentation script
let g:pymode_doc = 0
"rope script
let g:pymode_rope = 0
if (g:iswindows)
    let g:pymode_rope_project_root = $VIM
else
    let g:pymode_rope_project_root = "~/.vim"
endif
"let g:pymode_rope_ropefolder='.ropeproject'
"let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_checkers = ['pyflakes']
"virtualenv
let g:pymode_virtualenv = 0
"let g:pymode_virtualenv_path = d:/pyenv/flaskenv  "TODO

Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'vim-scripts/mako.vim'
"==============================END==============================

"============================Golang=============================
" vim-go
Plugin 'fatih/vim-go'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nnoremap <leader>r <Plug>(go-run)
au FileType go nnoremap <leader>b <Plug>(go-build)
au FileType go nnoremap <leader>t <Plug>(go-test)
"au FileType go nnoremap <leader>c <Plug>(go-coverage)

"au FileType go nnoremap <Leader>ds <Plug>(go-def-split)
"au FileType go nnoremap <Leader>dv <Plug>(go-def-vertical)
"au FileType go nnoremap <Leader>dt <Plug>(go-def-tab)

au FileType go nnoremap <Leader>gd <Plug>(go-doc)
au FileType go nnoremap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nnoremap <Leader>gb <Plug>(go-doc-browser)
"au FileType go nnoremap <Leader>s <Plug>(go-implements)
au FileType go nnoremap <Leader>i <Plug>(go-info)
"au FileType go nnoremap <Leader>e <Plug>(go-rename)
"==============================END==============================

"============================JavaScript=========================
Plugin 'pangloss/vim-javascript'

" JSX 语法
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0

"Plugin 'marijnh/tern_for_vim'
"==============================END==============================

"============================文件浏览===========================
" Tagbar F9 切换
Plugin 'majutsushi/tagbar'
nnoremap <F9> :TagbarToggle<CR><c-l>

" ctrlp
Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"上两行是默认配置，不添加也行
let g:ctrlp_working_path_mode = 'ra'
if g:iswindows
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
else
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
endif
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }
" 一旦CtrlP被打开了，就可以使用以下的命令
" <F5> 清除当前目录下的缓存，获取新的结构
" <c-f>和<c-b> 在各个模式下转换
" <c-d> 使用文件名搜索代替全路径搜索
" <c-r> 使用正则模式
" <c-j>和<c-k> 上下选择文件
" <c-t> <c-v>和<c-x> 在新的tab或者新的分割窗口打开选择的文件
" <c-n>和<c-p> 找到之前或者之后查找的字符串
" <c-y> 创建一个新的文件
" <c-z> 标记或者取消标记多个文件然后使用<c-o>打开它们

" 多个tab时, 保持nerdtree一致
Plugin 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_console_startup = 0

" 文件浏览器 F8
Plugin 'The-NERD-tree'
"map <leader>nt :NERDTree<CR> " 避免以n开头，拖缓搜索时n的速度
"map <F8> :NERDTreeToggle<CR> " F8开关NERDTree
noremap <F8> :NERDTreeTabsToggle<CR> " F8开关所有NERDTree
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"auto close
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
" o       在已有窗口中打开文件、目录或书签，并跳到该窗口
" go      在已有窗口 中打开文件、目录或书签，但不跳到该窗口
" t       在新 Tab 中打开选中文件/书签，并跳到新 Tab
" T       在新 Tab 中打开选中文件/书签，但不跳到新 Tab
" i       split 一个新窗口打开选中文件，并跳到该窗口
" gi      split 一个新窗口打开选中文件，但不跳到该窗口
" s       vsplit 一个新窗口打开选中文件，并跳到该窗口
" gs      vsplit 一个新 窗口打开选中文件，但不跳到该窗口
" !       执行当前文件
" O       递归打开选中 结点下的所有目录
" x       合拢选中结点的父目录
" X       递归 合拢选中结点下的所有目录
" e       Edit the current dif

" 双击    相当于 NERDTree-o
" 中键    对文件相当于 NERDTree-i，对目录相当于 NERDTree-e

" D       删除当前书签

" P       跳到根结点
" p       跳到父结点
" K       跳到当前目录下同级的第一个结点
" J       跳到当前目录下同级的最后一个结点
" k       跳到当前目录下同级的前一个结点
" j       跳到当前目录下同级的后一个结点

" C       将选中目录或选中文件的父目录设为根结点
" u       将当前根结点的父目录设为根目录，并变成合拢原根结点
" U       将当前根结点的父目录设为根目录，但保持展开原根结点
" r       递归刷新选中目录
" R       递归刷新根结点
" m       显示文件系统菜单 #！！！然后根据提示进行文件的操作如新建，重命名等
" cd      将 CWD 设为选中目录

" I       切换是否显示隐藏文件
" f       切换是否使用文件过滤器
" F       切换是否显示文件
" B       切换是否显示书签

" q       关闭 NerdTree 窗口
" ?       切换是否显示 Quick Help
"==============================END==============================

"==============================外观==================================
" 状态栏增强展示
Plugin 'bling/vim-airline'
set laststatus=2
set t_Co=256
let g:airline_powerline_fonts = 1
"let g:airline_left_sep='>'
"let g:airline_right_sep='<'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' ?'
let g:airline#extensions#tabline#left_alt_sep = '|'

" 显示缩进等级
Plugin 'nathanaelkane/vim-indent-guides'
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" 显示CSS颜色
Plugin 'ap/vim-css-color'

" ==============================工具Tool==============================
" 对齐
Plugin 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>oa <Plug>(EasyAlign)
" leader+oa ==> Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap <leader>oa <Plug>(EasyAlign)

" 显示marks - 方便自己进行标记和跳转
Plugin 'kshenoy/vim-signature'
" m<Space>  del all marks
" m[a-zA-Z] add mark
" '[a-zA-Z] go to mark
" Type "<c-y>," to complete

"Plugin 'sirver/ultisnips'
"" Snippets are separated from the engine. Add this if you want them:
"Plugin 'honza/vim-snippets'
"" Trigger configuration. Do not use <tab> if you use
"" https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"
"==============================END====================================

"======================= 插件必须放在此行之前 ========================
call vundle#end()            " required
filetype plugin indent on    " required
"Brief help
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
":PluginList          - list configured plugins
":PluginInstall(!)    - install(update) plugins
":PluginSearch(!) foo - search(or refresh cache first) for foo
":PluginClean(!)      - confirm(or auto-approve) removal of unused plugins
" ======================= 插件管理结束 PERSONAL START ================

" === Colorscheme配置 ===
" GUI: solarized
" Terminal: gruvbox
set background=dark
if g:isGUI
    "colorscheme desert
    colorscheme solarized
else
    "colorscheme torte
    "colorscheme molokai
    colorscheme gruvbox
endif

" === 编码配置 ====
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
" 设置gvim内部编码，默认不更改
set encoding=utf-8
" 设置当前文件编码，可以更改，如：gbk（同cp936）
set fileencoding=utf-8
" 设置支持打开的文件的编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1

" 文件格式，默认 ffs=dos,unix
set fileformat=unix             "设置新（当前）文件的<EOL>格式，可以更改，如：dos（windows系统常用）
set fileformats=unix,dos,mac    "给出文件的<EOL>格式类型

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

" === 编写文件时的配置 ===
" 空格代替tab
set expandtab
" >>命令缩进的大小=4
set shiftwidth=4
set tabstop=4
set softtabstop=4
" 指定按一次backspace就删除shiftwidth宽度
set smarttab
" 按照 C 语言的语法，自动地调整缩进的长度
set cindent
" 自动地将当前行的缩进拷贝到新行，也就是"自动对齐”
set noautoindent
" 自动闭合缩进
set smartindent

" 启用折叠
set foldenable
" 启动时开启的折叠层数
set foldlevel=5
"折叠方式有 indent, marker, syntax，这里是indent
set foldmethod=indent
"忽略的行开头
set foldignore=

"========= 包含函数名行的折叠函数 ===========
autocmd FileType python set foldmethod=expr | set foldexpr=GetPotionFold(v:lnum)

function! GetPotionFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        "它告知vim，这一行的foldlevel为"undefined"。
        "vim将把它理解为"该行的foldlevel等于其上一行或下一行的较小的那个foldlevel"。
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction

" === Other ===
" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=5

" 常规模式下用空格键来开关光标行所在折叠（注：zR 展开所有折叠，zM 关闭所有折叠）
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 当文件在外部被修改，自动更新该文件
set autoread

" 常规模式下输入 cS 清除行尾空格
nnoremap cS :%s/\s\+$//g<CR>:noh<CR>
" 常规模式下输入 cM 清除行尾 ^M 符号
nnoremap cM :%s/\r$//g<CR>:noh<CR>
" convert tab to 4 space
nnoremap cT :%s/\t/    /g<CR>:noh<CR>

" ======= 引号/括号自动匹配 禁止/启用 ======= "
au FileType scheme,racket,lisp,clojure :inoremap ' '
au FileType scheme,racket,lisp,clojure :inoremap ` `
au FileType markdown :inoremap * **<esc>i

" 关闭兼容VI按键
set nocompatible
" 开启文件类型侦测,根据侦测到的不同类型加载对应的插件,并采用不同的缩进
filetype plugin indent on
"共用系统剪贴板
"http://vim.wikia.com/wiki/Accessing_the_system_clipboard
"set clipboard+=unnamedplus
"文本选择后自动复制到系统粘贴板:怎么用？
"set guioptions+=a
" 启用鼠标
set mouse=a

" === Files ===
set autochdir
" 保存文件前建立备份，保存成功后删除该备份
set writebackup
" 无备份文件
set nobackup
"无临时文件
"set noswapfile
"退出vim后，内容显示在终端屏幕, 可以用于查看和复制。
"set t_ti= t_te=

" === 全局变量 ===
" 历史记录条数
set history=2000

" === 搜索设置 ===
" 高亮搜索词
set hlsearch
" 实时匹配
set incsearch
" 忽略大小写
set ignorecase
" 另外：==的行为取决于用户的设置
" ==?是"无论你怎么设都大小写不敏感"比较操作符
" ==#是"无论你怎么设都大小写敏感"比较操作符

" 从头开始循环查找
set wrapscan
" vim 自身命令行模式智能补全
set wildmenu
"close persistent undo with the '*.un~'
"set noundofile
" Keep search pattern at the center of the screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" === 外观设置 ===
" 显示行号
set relativenumber number
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber number
    else
        set relativenumber
    endif
endfunction
nnoremap <F3> :call NumberToggle()<cr> " 切换绝对/相对行号

" 去掉欢迎界面
set shortmess=atI
" 语法高亮开启
syntax on
" 显示括号配对情况
set showmatch
" 匹配括号显示时长
set matchtime=2
set cursorline
set cursorcolumn
set gcr=n-v:block-blinkon0,i:ver25-Cursor-blinkon0,r:hor20-Cursor-blinkon0

" === 状态栏设置 ===
" 显示按键
set showcmd
" 显示模式状态
set showmode
set ruler
" 高度
set cmdheight=2
set visualbell
"显示特殊字符，其中Tab使用高亮~代替，尾部空白使用高亮点号代替
"set list
" 按键超时
set timeout timeoutlen=800

" === 窗口设置 ===
" 设置 gVim 窗口初始位置及大小
if g:isGUI
    "au GUIEnter * simalt ~x "窗口启动时自动最大化
    winpos 150 5 "指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=40 columns=120 "指定窗口大小，lines为高度，columns为宽度
endif

" === 字体设置 ===
" 注意不同平台的字体设置方式区别
if (has("gui_gtk2") || has("gui_gtk3"))
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
elseif has("gui_macvim")
    "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13
    set guifont=Inconsolata\ for\ Powerline:h16
elseif has("gui_win32")
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
endif

" === 按键设置 ===
" 设置 Leader 为 ,
let mapleader=","
let maplocalleader=","
" ; ==> :
nnoremap ; :
" @@ ==> 邮箱
iabbrev @@ garden.yuen@gmail.com
"Go to the head and end
"noremap H ^
"noremap L $
" c+s+up 上移当前行
nnoremap <C-S-Up> ddkP
" c+s+down 下移当前行
nnoremap <C-S-Down> ddp
" Ctrl + H 光标移动[插入模式]、切换左窗口[Normal模式]
inoremap <c-h> <left>
noremap <c-h> <c-w><c-h>
" Ctrl + L 光标移动[插入模式]、切换右窗口[Normal模式]
inoremap <c-l> <right>
noremap <c-l> <c-w><c-l>
" Ctrl + J 光标移动[插入模式]、切换下窗口[Normal模式]
inoremap <c-j> <down>
noremap <c-j> <c-w><c-j>
" Ctrl + K 光标移动[插入模式]、切换上窗口[Normal模式]
inoremap <c-k> <up>
noremap <c-k> <c-w><c-k>

" leader+w ==> 插入模式保存
inoremap <leader>w <ESC>:w<CR>l
" leader*2 ==> esc [i,v]
inoremap <leader><leader> <ESC>l
vnoremap <leader><leader> <ESC>
" jk ==> esc [i]
inoremap jk <esc>l
" leader*2 ==> add , after current line [n]
nnoremap <leader>, mzA,<esc>`z

" add new blank
nnoremap <C-n><C-j> mzo<esc>`z
nnoremap <C-n><C-k> mzO<esc>`z

"================ 编辑映射 EDIT MAPPING =================
" c+u 转换当前单词为大写 [i]
inoremap <c-u> <esc>viwU<esc>ea
" leader+['/"/`] ==> 为word添加引号 [n]
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>` viw<esc>a`<esc>hbi`<esc>lel
nnoremap <leader>* viw<esc>a*<esc>hbi*<esc>lel
" add ; after line
nnoremap <leader>; mz A;<esc>`q
inoremap <leader>; <esc>mz A;<esc>`za
" simple align current file [n]
nnoremap <leader>= gg=G

" === Tabs操作 ===
" leader+[h/l] ==> first/last tab [n]
nnoremap <leader>h :tabfirst<cr>
nnoremap <leader>l :tablast<cr>

" leader+[j/k] ==> next/pre tab [n]
nnoremap <leader>j :tabnext<cr>
nnoremap <leader>k :tabprev<cr>

" leader+[e/d/D] ==> tab edit/close/close!
nnoremap <leader>e :tabedit<cr>
nnoremap <leader>d :tabclose<cr>
nnoremap <leader>D :tabclose!<cr>

"move current tab to, default last
nnoremap <leader>m :tabm
"nnoremap <leader>bt :bufdo tab split<cr>

" Ctrl+t ==> 新建tab
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" Ctrl+x ==> 删除行 来源sublime
nnoremap <C-x> dd
" Ctrl+c ==> 复制行 来源sublime
nnoremap <C-c> V"+y

" ============== New File =====================
" create a .c,.h,.sh,.java file,automatic insert a title
autocmd BufRead,BufNewFile *.{md,markdown} set filetype=markdown
autocmd BufNewFile *.py,*.cpp,*.[ch],*.sh,*.java,*.{md,markdown} exec ":call SetTitle()"
"define a funtion [SetTitle] automatic a title
function! SetTitle()
    ".sh file
    if &filetype == 'sh'
        call setline(1,          "\#########################################################################")
        call append(line("."),   "\# File Name: ".expand("%"))
        call append(line(".")+1, "\# Author: weaming")
        call append(line(".")+2, "\# mail: garden.yuen@gmail.com")
        call append(line(".")+3, "\# Created Time: ".strftime("20%y-%m-%d %H:%M:%S"))
        call append(line(".")+4, "\#########################################################################")
        call append(line(".")+5, "\#!/bin/bash")
        call append(line(".")+6, "")
    endif
    if &filetype == 'cpp'
        call setline(1,          "/*************************************************************************")
        call append(line("."),   "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: weaming")
        call append(line(".")+2, "    > Mail: garden.yuen@gmail.com")
        call append(line(".")+3, "    > Created Time: ".strftime("20%y-%m-%d %H:%M:%S"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call setline(1,          "/*************************************************************************")
        call append(line("."),   "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: weaming")
        call append(line(".")+2, "    > Mail: garden.yuen@gmail.com")
        call append(line(".")+3, "    > Created Time: ".strftime("20%y-%m-%d %H:%M:%S"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/python")
        call setline(2, "\# coding: utf-8")
        call setline(3, "\"\"\"")
        call setline(4, "Author       : weaming")
        call setline(5, "Created Time : ".strftime("20%y-%m-%d %H:%M:%S"))
        call setline(6, "")
        call setline(7, "File Name    : ".expand("%"))
        call setline(8, "Description  :")
        call setline(9, "")
        call setline(10, "\"\"\"")
    endif
    "create a file，automatic position the end of file
    autocmd BufNewFile * normal G
endfunc

" ============== AUTOCMD =====================
function! RemoveSpace()
    silent! %s/\s\+$//g
    :nohlsearch
endfunction
function! BeforeSave()
    :call RemoveSpace()
endfunction

augroup savefile
    "clear existed command group with the same name
    autocmd!
    " 文件保存时，清除尾部多余空格
    autocmd BufWritePre,FileAppendPre,FileWritePre,FilterWritePre * :call BeforeSave()
    " 文件保存时，替换Tab为4个空格
    autocmd BufWritePre *.* retab! 4
    " html文件读取或创建时不换行
    autocmd BufNewFile,BufRead *.html setlocal nowrap
augroup END

" localleader+/ ==> auto simple comment
augroup editcode
    "clear existed command group with the same name
    autocmd!
    autocmd FileType python     nnoremap <buffer> <localleader>/ I#<esc>
    autocmd FileType javascript nnoremap <buffer> <localleader>/ I//<esc>
    autocmd FileType python     :iabbrev <buffer> iff if:<left>
    autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
augroup END


" ============== MOVEMENT MAPPING ==================
"d( ==> di( ==> delete in bracket
"onoremap ( i(

" 选择括号里的内容
" when before ()
onoremap ( :<c-u>normal! f(vi(<cr>
" when after ()
onoremap ) :<c-u>normal! F)vi(<cr>

" markdown: change inside heading(search "==")
onoremap mh :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
"============== MOVEMENTMAPPING END ====================

" === session ===
" leader+ss ==> 保存当前会话
" leader+es ==> 载入上次保存的会话
if g:islinux
    nnoremap <leader>ss :mksession! ~/.mysession.vim<cr>
    nnoremap <leader>es :source ~/.mysession.vim<cr>
else
    nnoremap <leader>ss :mksession! $VIM/.mysession.vim<cr>
    nnoremap <leader>es :source $VIM/.mysession.vim<cr>
endif

" === EDIT ===
" leader+a ==> select All [n]
nnoremap <leader>sa ggVG
" leader+y ==> 将选中文本块复制至系统剪贴板 [n,v]
vnoremap <Leader>y "+y
nnoremap <Leader>y V"+y
" leader+p ==> 将系统剪贴板内容粘贴至 vim [n,v,i]
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
inoremap <Leader>p <esc>"+p
" leader+q ==> 关闭当前分割窗口 [n,i]
nnoremap <Leader>q :q<CR>
inoremap <Leader>q <esc>:q<CR>
" leader+w ==> 保存当前窗口内容 [n]
nnoremap <Leader>w :w<CR>
"保存所有窗口内容并退出
"nnoremap <Leader>WQ :wa<CR>:q<CR>
" leader+W ==> 无权限保存时sudo [n]
nnoremap <Leader>W :w !sudo tee %<CR>
" leader+Q ==> 不做任何保存&退出 vim [n]
nnoremap <Leader>Q :q!<CR>
" leader+a ==> 复制所有至公共剪贴板 [n]
nnoremap <leader>a <esc>ggVG"+y<esc>
" leader+ev ==> 编辑当前所使用的Vim配置文件 [n]
nnoremap <leader>ev <esc>:tabnew $MYVIMRC<cr>
" leader+sv ==> 载入当前所使用的Vim配置文件 [n]
nnoremap <leader>sv :source $MYVIMRC<cr>
" < or > ==> 调整缩进后自动选中，方便再次操作 [v]
vnoremap < <gv
vnoremap > >gv

" === 切换语法高亮 [n,i] ===
" leader+xphp ==> 一键切换到PHP语法高亮
inoremap <leader>xphp <esc>:se ft=php<cr>li
nnoremap <leader>xphp <esc>:se ft=php<cr>
" leader+xjs ==> 一键切换到JavaScript语法高亮
inoremap <leader>xjs <esc>:set ft=javascript<cr>li
nnoremap <leader>xjs <esc>:set ft=javascript<cr>
" leader+xcss ==> 一键切换到CSS语法高亮
inoremap <leader>xcss <esc>:se ft=css<cr>li
nnoremap <leader>xcss <esc>:se ft=css<cr>
" leader+xhtml ==> 一键切换到HTML语法高亮
inoremap <leader>xhtml <esc>:se ft=html<cr>li
nnoremap <leader>xhtml <esc>:se ft=html<cr>
" leader+xpy ==> 一键切换到PYTHON语法高亮
inoremap <leader>xpy <esc>:se ft=Python<cr>li
nnoremap <leader>xpy <esc>:se ft=Python<cr>
" leader+xvi ==> 一键切换到VIM配置文件语法高亮
inoremap <leader>xvi <esc>:se ft=vim<cr>li
nnoremap <leader>xvi <esc>:se ft=vim<cr>

" === 上排F功能键 ===
" // F2 行号开关，用于鼠标复制代码用
" F2重新载入vim配置
" F3 切换绝对/相对行号
" F4 显示可打印字符开关
" F5 粘贴模式paste_mode开关,用于有格式的代码粘贴
" F6 语法开关，关闭语法可以加快大文件的展示
" F7 换行开关
" F8开关NERDTree
" F9开关Tagbar
" F11在linux环境可切换全屏
" Linux: 先自行安装 wmctrl: sudo apt-get install wmctrl -y
" Windows: Put gvim_fullscreen.dll into the same directory where gvim.exe located.
" F12 切换窗口透明度
function! HideNumber()
    if(&relativenumber == &number)
        set relativenumber! number!
    elseif(&number)
        set number!
    else
        set relativenumber!
    endif
    set number?
endfunction
"nnoremap <F2> :call HideNumber()<CR>
nnoremap <F2> :source $MYVIMRC<cr>
nnoremap <F4> :set list! list?<CR>
set pastetoggle=<F5> "插入模式粘贴不会自动缩进避免混乱
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>
nnoremap <F7> :set wrap! wrap?<CR>

" Ctrl+F11 ==> 显示/隐藏菜单栏、工具栏、滚动条
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nnoremap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
                \set guioptions-=m <Bar>
                \set guioptions-=T <Bar>
                \set guioptions-=r <Bar>
                \set guioptions-=L <Bar>
                \else <Bar>
                \set guioptions+=m <Bar>
                \set guioptions+=T <Bar>
                \set guioptions+=r <Bar>
                \set guioptions+=L <Bar>
                \endif<CR>
endif

"F11全屏
if g:islinux
    "先自行安装 wmctrl: sudo apt-get install wmctrl -y
    "将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
    fun! ToggleFullscreen()
        call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
    endf
    "全屏开/关快捷键
    if g:isGUI
        map <silent> <F11> :call ToggleFullscreen()<CR>
        "启动 vim 时自动全屏
        "autocmd VimEnter * call ToggleFullscreen()
    endif
endif

if (g:iswindows && g:isGUI)
    "Thanks to https://github.com/movsb/gvim_fullscreen
    "Put gvim_fullscreen.dll into the same directory where gvim.exe located.
    "按 F11 切换全屏
    noremap <f11> <esc>:call libcallnr('gvim_fullscreen.dll', 'ToggleFullscreen', 0)<cr>
    "按 F12 切换窗口透明度
    noremap <f12> <esc>:call libcallnr('gvim_fullscreen.dll', 'ToggleTransparency', "230,200")<cr>
endif

