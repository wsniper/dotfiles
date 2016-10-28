
## Package Dependences 

- `ctags`

## 插件管理核心库 


        Plugin 'VundleVim/Vundle.vim'

- `如果你的插件来自github，写在下方，只要作者名/项目名就行了`
- `Plugin 'tpope/vim-fugitive'`
- `如果插件来自 vim-scripts，你直接写插件名就行了`
- `Plugin 'L9'`
- `如使用自己的git库的插件，像下面这样做`
- `Plugin 'git://git.wincent.com/command-t.git'`
- `本地插件`
- `Plugin 'file:///Users/gmarik/path/to/plugin'`

## 语法通用 


        Plugin 'othree/html5.vim'


## 语法补全 

- `自动补全html/xml标签`

        Plugin 'docunext/closetag.vim'


## 语法美化 

- `格式化`

        Plugin 'jsbeautify'

- `usage:<leader>ff`

## 色彩主题 


        Plugin 'tomasr/molokai'

- `gruvbox主题`

        Plugin 'morhetz/gruvbox'

- `solarized主题`

        Plugin 'altercation/vim-colors-solarized'


## 编辑 

- `选中区块`

        Plugin 'terryma/vim-expand-region'

- `多光标选中编辑`

        Plugin 'terryma/vim-multiple-cursors'

- `ctrl + m 开始选择`
- `ctrl + p 向上取消`
- `ctrl + x 跳过`
- `更改包围的字符`

        Plugin 'tpope/vim-surround'

- `命令示例:`
- `origin: "Hello world!"`
- `cs"' ==> 'Hello world!'`
- `cs'<q> ==> <q>Hello world!</q>`
- `To go full circle, press cst" ==> "Hello world!"`
- `ds" ==> Hello world!`
- `光标置于 Hello 上面：`
- `ysiw] ==> [Hello] world!  (iw is a text object)`
- `cs]{ ==> { Hello } world! (如果使用 } 则没有空格)`
- `yssb or yss) ==> ({ Hello } world!)`
- `ds{ds) ==> Hello world!`
- `Emphasize hello: ysiw<em> ==> <em>Hello</em>em> world!`
- `Visual Mode: press V:`
- `S<p class="important"> ==> just try yourself :)`
- `The . command will work with ds, cs, and yss if you install `repeat.vim`.`
- `Emmet 不解释`

        Plugin 'mattn/emmet-vim'

- `快捷注释插件`

        Plugin 'The-NERD-Commenter'

- `<leader>cc 注释当前行`
- `<leader>cn 同上，但是强制嵌套`
- `<leader>c<space> 切换当前选择的行的注释状态`
- `<leader>cm Comments the given lines using only one set of multipart delimiters.`
- `<leader>ci 分别切换选择行的注释状态`
- `<leader>cs 性感地注释多行`
- `<leader>cy Same as <leader>cc except that the commented line(s) are yanked first.`
- `<leader>c$ 注释当前行到行尾`
- `<leader>cA 在行尾添加注释`
- `<leader>ca 在可选的注释方式之间切换`
- `<leader>cu 取消注释当前行或多行`
- `Provides insert mode auto-completion for quotes, parens, brackets, etc.`

        Plugin 'raimondi/delimitmate'

- `更快捷地编辑表格`

        Plugin 'dhruvasagar/vim-table-mode'

- `To start using the plugin in the on-the-fly mode use :TableModeToggle mapped to <Leader>tm by default.`
- `Enter the first line, delimiting columns by the `|` symbol. The plugin reacts by inserting spaces between the text and the separator if you omit them:`
- `In the second line (without leaving Insert mode), enter `|` twice. The plugin will write a properly formatted horizontal line:`
- `When you enter the subsequent lines, the plugin will automatically adjust the formatting to match the text you’re entering every time you press `|`.`
- `Go on until the table is ready.`
- `Then you can return to the first line and above it enter `||`.`

        Plugin 'tpope/vim-fugitive'

- `:Git   :Gstatus    :Gcommit    :Gpush    :Gpull`

        Plugin 'airblade/vim-gitgutter'


        Plugin 'klen/python-mode'


        Plugin 'Glench/Vim-Jinja2-Syntax'


        Plugin 'vim-scripts/mako.vim'

- `vim-go`

        Plugin 'fatih/vim-go'


        Plugin 'pangloss/vim-javascript'

- `JSX 语法`

        Plugin 'mxw/vim-jsx'

- `Tagbar F9 切换`

        Plugin 'majutsushi/tagbar'

- `ctrlp`

        Plugin 'kien/ctrlp.vim'

- `一旦CtrlP被打开了，就可以使用以下的命令`
- `<F5> 清除当前目录下的缓存，获取新的结构`
- `<c-f>和<c-b> 在各个模式下转换`
- `<c-d> 使用文件名搜索代替全路径搜索`
- `<c-r> 使用正则模式`
- `<c-j>和<c-k> 上下选择文件`
- `<c-t> <c-v>和<c-x> 在新的tab或者新的分割窗口打开选择的文件`
- `<c-n>和<c-p> 找到之前或者之后查找的字符串`
- `<c-y> 创建一个新的文件`
- `<c-z> 标记或者取消标记多个文件然后使用<c-o>打开它们`
- `多个tab时, 保持nerdtree一致`

        Plugin 'jistr/vim-nerdtree-tabs'

- `文件浏览器 F8`

        Plugin 'The-NERD-tree'

- `o       在已有窗口中打开文件、目录或书签，并跳到该窗口`
- `go      在已有窗口 中打开文件、目录或书签，但不跳到该窗口`
- `t       在新 Tab 中打开选中文件/书签，并跳到新 Tab`
- `T       在新 Tab 中打开选中文件/书签，但不跳到新 Tab`
- `i       split 一个新窗口打开选中文件，并跳到该窗口`
- `gi      split 一个新窗口打开选中文件，但不跳到该窗口`
- `s       vsplit 一个新窗口打开选中文件，并跳到该窗口`
- `gs      vsplit 一个新 窗口打开选中文件，但不跳到该窗口`
- `!       执行当前文件`
- `O       递归打开选中 结点下的所有目录`
- `x       合拢选中结点的父目录`
- `X       递归 合拢选中结点下的所有目录`
- `e       Edit the current dif`
- `双击    相当于 NERDTree-o`
- `中键    对文件相当于 NERDTree-i，对目录相当于 NERDTree-e`
- `D       删除当前书签`
- `P       跳到根结点`
- `p       跳到父结点`
- `K       跳到当前目录下同级的第一个结点`
- `J       跳到当前目录下同级的最后一个结点`
- `k       跳到当前目录下同级的前一个结点`
- `j       跳到当前目录下同级的后一个结点`
- `C       将选中目录或选中文件的父目录设为根结点`
- `u       将当前根结点的父目录设为根目录，并变成合拢原根结点`
- `U       将当前根结点的父目录设为根目录，但保持展开原根结点`
- `r       递归刷新选中目录`
- `R       递归刷新根结点`
- `m       显示文件系统菜单 #！！！然后根据提示进行文件的操作如新建，重命名等`
- `cd      将 CWD 设为选中目录`
- `I       切换是否显示隐藏文件`
- `f       切换是否使用文件过滤器`
- `F       切换是否显示文件`
- `B       切换是否显示书签`
- `q       关闭 NerdTree 窗口`
- `?       切换是否显示 Quick Help`
- `状态栏增强展示`

        Plugin 'bling/vim-airline'

- `显示缩进等级`

        Plugin 'nathanaelkane/vim-indent-guides'

- `显示CSS颜色`

        Plugin 'ap/vim-css-color'


## 工具Tool

- `对齐`

        Plugin 'junegunn/vim-easy-align'

- `Start interactive EasyAlign in visual mode (e.g. vipga)`
- `leader+oa ==> Start interactive EasyAlign for a motion/text object (e.g. gaip)`
- `显示marks - 方便自己进行标记和跳转`

        Plugin 'kshenoy/vim-signature'

- `m<Space>  del all marks`
- `m[a-zA-Z] add mark`
- `'[a-zA-Z] go to mark`
- `Type "<c-y>," to complete`

## 插件管理结束 PERSONAL START 


## Colorscheme配置 

- `GUI: solarized`
- `Terminal: gruvbox`

## 编码配置 

- `注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错`
- `设置gvim内部编码，默认不更改`
- `设置当前文件编码，可以更改，如：gbk（同cp936）`
- `设置支持打开的文件的编码`
- `文件格式，默认 ffs=dos,unix`

## 编写文件时的配置 

- `空格代替tab`
- `>>命令缩进的大小=4`
- `指定按一次backspace就删除shiftwidth宽度`
- `按照 C 语言的语法，自动地调整缩进的长度`
- `自动地将当前行的缩进拷贝到新行，也就是"自动对齐”`
- `自动闭合缩进`
- `启用折叠`
- `启动时开启的折叠层数`

## Other 

- `在上下移动光标时，光标的上方或下方至少会保留显示的行数`
- `常规模式下用空格键来开关光标行所在折叠（注：zR 展开所有折叠，zM 关闭所有折叠）`
- `当文件在外部被修改，自动更新该文件`
- `常规模式下输入 cS 清除行尾空格`
- `常规模式下输入 cM 清除行尾 ^M 符号`
- `convert tab to 4 space`

## 引号/括号自动匹配 禁止/启用  "

- `关闭兼容VI按键`
- `开启文件类型侦测,根据侦测到的不同类型加载对应的插件,并采用不同的缩进`
- `启用鼠标`

## Files 

- `保存文件前建立备份，保存成功后删除该备份`
- `无备份文件`

## 全局变量 

- `历史记录条数`

## 搜索设置 

- `高亮搜索词`
- `实时匹配`
- `忽略大小写`
- `另外：==的行为取决于用户的设置`
- `==?是"无论你怎么设都大小写不敏感"比较操作符`
- `==#是"无论你怎么设都大小写敏感"比较操作符`
- `从头开始循环查找`
- `vim 自身命令行模式智能补全`
- `Keep search pattern at the center of the screen`

## 外观设置 

- `显示行号`
- `去掉欢迎界面`
- `语法高亮开启`
- `显示括号配对情况`
- `匹配括号显示时长`

## 状态栏设置 

- `显示按键`
- `显示模式状态`
- `高度`
- `按键超时`

## 窗口设置 

- `设置 gVim 窗口初始位置及大小`

## 字体设置 

- `注意不同平台的字体设置方式区别`

## 按键设置 

- `设置 Leader 为 ,`
- `; ==> :`
- `@@ ==> 邮箱`
- `c+s+up 上移当前行`
- `c+s+down 下移当前行`
- `Ctrl + H 光标移动[插入模式]、切换左窗口[Normal模式]`
- `Ctrl + L 光标移动[插入模式]、切换右窗口[Normal模式]`
- `Ctrl + J 光标移动[插入模式]、切换下窗口[Normal模式]`
- `Ctrl + K 光标移动[插入模式]、切换上窗口[Normal模式]`
- `leader+w ==> 插入模式保存`
- `leader*2 ==> esc [i,v]`
- `jk ==> esc [i]`
- `leader*2 ==> helloVIM [n]`
- `c+u 转换当前单词为大写 [i]`
- `leader+['/"/`] ==> 为word添加引号 [n]`
- `粘贴后保存历史`
- `add ; after line`

## Tabs操作 

- `leader+[h/l] ==> first/last tab [n]`
- `leader+[j/k] ==> next/pre tab [n]`
- `leader+[e/d/D] ==> tab edit/close/close!`
- `Ctrl+t ==> 新建tab`
- `Ctrl+x ==> 删除行 来源sublime`
- `Ctrl+c ==> 复制行 来源sublime`

## AUTOCMD 

- `文件保存时，清楚尾部多余空格`
- `html文件读取或创建时不换行`
- `localleader+/ ==> auto simple comment`

## MOVEMENT MAPPING 

- `选择括号里的内容`
- `when in ()`
- `when before ()`
- `when after ()`
- `start with 'i' to distinguish built-in command such <,>," and so on`
- `markdown: change inside heading(search "==")`

## session 

- `leader+ss ==> 保存当前会话`
- `leader+es ==> 载入上次保存的会话`

## EDIT 

- `leader+a ==> select All [n]`
- `leader+y ==> 将选中文本块复制至系统剪贴板 [n,v]`
- `leader+p ==> 将系统剪贴板内容粘贴至 vim [n,v,i]`
- `leader+q ==> 关闭当前分割窗口 [n,i]`
- `leader+w ==> 保存当前窗口内容 [n]`
- `leader+W ==> 无权限保存时sudo [n]`
- `leader+Q ==> 不做任何保存&退出 vim [n]`
- `leader+a ==> 复制所有至公共剪贴板 [n]`
- `leader+ev ==> 编辑当前所使用的Vim配置文件 [n]`
- `leader+sv ==> 载入当前所使用的Vim配置文件 [n]`
- `< or > ==> 调整缩进后自动选中，方便再次操作 [v]`

## 切换语法高亮 [n,i] 

- `leader+xphp ==> 一键切换到PHP语法高亮`
- `leader+xjs ==> 一键切换到JavaScript语法高亮`
- `leader+xcss ==> 一键切换到CSS语法高亮`
- `leader+xhtml ==> 一键切换到HTML语法高亮`
- `leader+xpy ==> 一键切换到PYTHON语法高亮`
- `leader+xvi ==> 一键切换到VIM配置文件语法高亮`

## 上排F功能键 

- `F2重新载入vim配置`
- `F3 切换绝对/相对行号`
- `F4 显示可打印字符开关`
- `F5 粘贴模式paste_mode开关,用于有格式的代码粘贴`
- `F6 语法开关，关闭语法可以加快大文件的展示`
- `F7 换行开关`
- `F8开关NERDTree`
- `F9开关Tagbar`
- `F11在linux环境可切换全屏`
- `Linux: 先自行安装 wmctrl: sudo apt-get install wmctrl -y`
- `Windows: Put gvim_fullscreen.dll into the same directory where gvim.exe located.`
- `F12 切换窗口透明度`
- `Ctrl+F11 ==> 显示/隐藏菜单栏、工具栏、滚动条`
