Usage
-----
```
bash install.sh full/product/update/fix
```
Read `install.sh` for details.

The details of `.vimrc`
----
The document generated from comments in setting file:

[vimrc-document.md](./vimrc-document.md)

1 My `.vimrc` settings file [>>](https://github.com/weaming/vimrc/blob/master/vimrc)
---
Paths you need put it in:

- *nix: `~/.vimrc`
- windows: `c:\Users\YOUNAME\.vimrc`

Plugins
---
```
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'othree/html5.vim'
Plugin 'docunext/closetag.vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'tomasr/molokai'
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized'
Plugin 'terryma/vim-expand-region'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'The-NERD-Commenter'
Plugin 'raimondi/delimitmate'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'klen/python-mode'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'vim-scripts/mako.vim'
Plugin 'fatih/vim-go'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'The-NERD-tree'
Plugin 'bling/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ap/vim-css-color'
Plugin 'junegunn/vim-easy-align'
Plugin 'kshenoy/vim-signature'
```

2 My `.bash_aliases` settings [>>](https://github.com/weaming/vimrc/blob/master/bash_aliases)
---
The path is: `~/.bash_aliases`

Because these are contained in file `~/.bashrc`:
```
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```

3 windows平台gvim配置
---
路径：`D:\Program Files (x86)\Vim\_vimrc`

依赖条件：git、curl

步骤：

1. 安装git;
2. 添加git的bin目录到环境path变量中：`D:\Program Files\Git\bin`
3. 在`D:\Program Files\Git\bin`目录添加`curl.cmd`文件，文件内容为：

```
@rem Do not use "echo off" to not affect any child calls.
@setlocal

@rem Get the abolute path to the parent directory, which is assumed to be the
@rem Git installation root.
@for /F "delims=" %%I in ("%~dp0..") do @set git_install_root=%%~fI
@set PATH=%git_install_root%\bin;%git_install_root%\mingw\bin;%git_install_root%\mingw64\bin;%PATH%
@rem !!!!!!! For 64bit msysgit, replace 'mingw' above with 'mingw64' !!!!!!!

@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@curl.exe %*
```
4,cmd验证安装成功与否：

```
git --version
curl --version
```
5,下载vundle：`git clone https://github.com/gmarik/vundle D:\Program Files (x86)\Vim\vimfiles\bundle\Vundle.vim` 路径可微调
6,更改配置为：

```
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
call vundle#begin('$VIM/vimfiles/bundle/')
```

注意：此处`call vundle#begin('$VIM/vimfiles/bundle/')`我在路径后面添加了`bundle/`，而github配置说明里是有bug的。因为我执行`:PluginClean`之后会删除多余的`bundle`，连`Vundel.vim`它自己都干掉了，结果再次打开的结果就是出错！

针对这个，我已经在配置中自动判断平台环境，自动使用对应设置：

```
if (g:iswindows && g:isGUI)
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$VIM/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif
```

Windows全屏无边框
----
1. Put `depends/gvim_fullscreen.dll` into the same directory where `gvim.exe` located.(Thanks to https://github.com/movsb/gvim_fullscreen)
2. 然后添加如下配置（最好先判断下是否Windows系统下的GUI环境）

```
" 按 F11 切换全屏
noremap <f11> <esc>:call libcallnr('gvim_fullscreen.dll', 'ToggleFullscreen', 0)<cr>
" 按 F12 切换窗口透明度
noremap <f12> <esc>:call libcallnr('gvim_fullscreen.dll', 'ToggleTransparency', "240,180")<cr>
```

字体
---
针对一些特殊符号，使用Patch过的字体

Shell
----
启动环境变量载入顺序（括号内为Mac，因为不会自动载入`.bashrc`）：

```
(.bash_profile) --> .bashrc --> .bash_aliases \
                                               ---> .aliases ---> .userrc(.macrc)
                    .zshrc  -->  .zsh_aliases /
```

参考链接：
- https://github.com/VundleVim/Vundle.vim/wiki/Vundle-for-Windows
- http://blog.csdn.net/zhuxiaoyang2000/article/details/8636472
