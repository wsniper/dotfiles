#!/bin/bash

work=~/.
new=./

var=vimrc
workVimrc=${work}${var}
newVimrc=${new}${var}
bakVimrc=${work}${var}.bak

var=vimrc.lite
workVimrcLite=${work}${var}
newVimrcLite=${new}${var}
bakVimrcLite=${work}${var}.bak

var=bash_aliases
workAlias=${work}${var}
newAlias=${new}${var}
bakAlias=${work}${var}.bak

var=npmrc
workNpmrc=${work}${var}
newNpmrc=${new}${var}
bakNpmrc=${work}${var}.bak

installBasicSoftware(){
    echo '安装将花费一定时间，请耐心等待直到安装完成^_^'
    echo

    if which apt-get >/dev/null; then
        sudo apt-get install git exuberant-ctags vim-gtk -y
    elif which yum >/dev/null; then
        sudo yum install git ctags vim-gtk -y
    elif which brew >/dev/null; then
        brew install git ctags macvim -y
    fi
    echo "安装git vim ctags完成!"
    cp ${new}bashmarks.sh ${work}bashmarks.sh
}

fixbashrc(){
    cat ./fixbashrc >> ~/.bashrc
    echo '已修复 ~/.bash_aliases 无效的问题'
}

installVundleVim(){
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 2>/dev/null
    echo "2.安装vundle.vim插件管理完成!"
    echo "weaming正在努力为您安装bundle程序" > weaming
    echo "安装完毕将自动退出" >> weaming
    echo "请耐心等待" >> weaming
    vim weaming -c "PluginInstall" -c "q" -c "q"
    rm -f weaming
    echo "3.安装VIM插件完成!"
}

installFileCommon(){
    if [ ! -f $bakNpmrc ];then
        cp -f $workNpmrc $bakNpmrc 2>/dev/null
        echo "已备份: ${bakNpmrc}"
    fi
    cp -f $newNpmrc $workNpmrc
    echo "1.复制.npmrc完成!"

    if [ ! -f $bakAlias ];then
        cp -f $workAlias $bakAlias 2>/dev/null
        echo "已备份: ${bakAlias}"
    fi
    cp -f $newAlias $workAlias
    echo "2.复制.bash_aliases完成!"

    installZshAliases
    echo "3.复制.zsh_aliases完成!"

    cp ./aliases ~/.aliases
    echo "4.复制.aliases完成!"
}

installVimrc(){
    if [ ! -f $bakVimrc ];then
        cp $workVimrc $bakVimrc 2>/dev/null
        echo "已备份: ${bakVimrc}"
    fi

    if [ -z $1 ];then
        tmp=$newVimrc
    else
        tmp=$1
    fi

    echo "0.Using $tmp"
    cp -f $tmp $workVimrc
    echo "1.复制 ${tmp} 完成!"

    if [ $tmp == $newVimrc ]; then
        installVundleVim
    fi
}

uninstallConfigFile(){
    cp -f $bakVimrc $workVimrc
    echo "1.还原.vimrc完成!"
    cp -f $bakAlias $workAlias
    source ~/.bashrc
    echo "2.还原.bash_aliases完成!"
}

cleanBackup(){
    files="$bakAlias $bakVimrc $bakNpmrc"
    rm -f $files
    echo "已删除 $files"
}

installZshAliases(){
    cp -f ./zsh/zsh_aliases ~/.zsh_aliases
}

configGitUser(){
    if [ -z "$(git config user.email)" ]; then
        read -p 'Your git user email ["garden.yuen@gmail.com"]: ' git_email
        [ -z "${git_email}" ] && git_email='garden.yuen@gmail.com'
        git config --global user.email "$git_email"
    fi

    if [ -z "$(git config user.name)" ]; then
        read -p 'Your git user name ["weaming"]: ' git_name
        [ -z "${git_name}" ] && git_name='weaming'
        git config --global user.name "$git_name"
    fi
}

configGit(){
    git config --global alias.st status
    git config --global alias.co checkout
    git config --global alias.ci commit
    git config --global alias.br branch
    git config --global alias.back 'reset --hard HEAD^'

    git config --global color.status auto
    git config --global color.branch auto
    git config --global color.interactive auto
    git config --global color.diff auto
    git config --global push.default current
    #git config --global push.default simple

    git config --global core.filemode false
    git config --global core.autocrlf input

    git config --global alias.unstage 'reset HEAD'
    git config --global alias.last 'log -1'
    git config --global alias.logg 'log --graph --pretty=oneline --abbrev-commit'

    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

    git config --global core.editor vim
    git config --global merge.tool vimdiff

    configGitUser

    echo "配置git完成!"
}

installScriptsTools(){
    echo
    git clone https://github.com/weaming/scripts.git ~/scripts 2>/dev/null
    echo "克隆scripts工具完成!"
}

################### 版本管理 #############
v_common(){
    echo ---------------------------
    installBasicSoftware
    echo ---------------------------
    configGit
    echo ---------------------------
    installFileCommon
}

v_fast(){
    v_common
    echo ---------------------------
    installVimrc $newVimrc
}

v_product(){
    v_common
    echo ---------------------------
    installVimrc $newVimrcLite
}

v_full(){
    v_fast
    echo ---------------------------
    installScriptsTools
}

v_update(){
    installVimrc
}

dosomething(){
    case "$1" in
        fast|full|product)
            v_$1
            ;;
        update)
            installVimrc
            ;;
        uninstall)
            uninstallConfigFile
            ;;
        fix)
            fixbashrc
            ;;
        *)
            return 1
    esac
}

if ! dosomething $1; then
    tips='[fast, full, product, update, uninstall, fix, cleanbackup]'
    echo "不正确的参数 $tips"
fi

echo
echo 'Now you can use command "f5" to refresh settings!'
