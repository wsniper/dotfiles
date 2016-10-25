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

function installBasicSoftware(){
    echo '安装将花费一定时间，请耐心等待直到安装完成^_^'
    if which apt-get >/dev/null; then
        sudo apt-get install git exuberant-ctags vim-nox -y
    elif which yum >/dev/null; then
        sudo yum install git ctags vim-nox -y
    fi
    echo "安装git vim ctags完成!"
    cp ${new}bashmarks.sh ${work}bashmarks.sh
}

function fixbashrc(){
    cat ./fixbashrc >> ~/.bashrc
    echo '已修复 ~/.bash_aliases 无效的问题'
}

function installFileCommon(){
    if [ ! -f $bakNpmrc ];then
        cp -f $workNpmrc $bakNpmrc
        echo "已备份${bacNpmrc}"
    fi
    cp -f $newNpmrc $workNpmrc
    echo "复制.npmrc完成!"

    if [ ! -f $bakVimrc ];then
        cp $workVimrc $bakVimrc
        echo "已备份${backVimrc}"
    fi
    eval $1
    echo "复制.vimrc完成!"

    if [ ! -f $bakAlias ];then
        cp -f $workAlias $bakAlias
        echo "已备份${bakAlias}"
    fi
    cp -f $newAlias $workAlias
    echo "复制.bash_aliases完成!"

    echo 'Now you can use command f5 to refresh settings!'
}

function installConfigFile(){
    echo '---------------------------'
    cmd="cp -f $newVimrc $workVimrc"
    echo 'Using .vimrc'
    installFileCommon "$cmd"
}

function installLiteConfigFile(){
    echo '---------------------------'
    cmd="cp -f $newVimrcLite $workVimrc"
    echo 'Using .vimrc.lite'
    installFileCommon "$cmd"
}

function uninstallConfigFile(){
    cp -f $bakVimrc $workVimrc
    echo "还原.vimrc完成!"
    cp -f $bakAlias $workAlias
    source ~/.bashrc
    echo "还原.bash_aliases完成!"
}

function cleanBackup(){
    files="$bakAlias $bakVimrc $bakNpmrc"
    rm -f $files
    echo "已删除 $files"
}

function configGit(){
    echo '---------------------------'
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

    echo "配置git完成!"
}

function installVim(){
    echo '---------------------------'
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "安装vundle.vim插件管理完成!"
    echo "weaming正在努力为您安装bundle程序" > weaming
    echo "安装完毕将自动退出" >> weaming
    echo "请耐心等待" >> weaming
    vim weaming -c "PluginInstall" -c "q" -c "q"
    rm weaming
    echo "安装VIM插件完成!"
}

function installShellTools(){
    echo '---------------------------'
    git clone https://github.com/weaming/shell.git ~/shell
    echo "迁移shell工具完成!"
}


function v_fast(){
    installBasicSoftware
    configGit
    installConfigFile
    installVim
}

function v_full(){
    installBasicSoftware
    configGit
    installShellTools
    installConfigFile
    installVim
}

function v_product(){
    installBasicSoftware
    configGit
    installLiteConfigFile
    installVim
}

tips='[fast, full, product, update, restore, fix, cleanbackup]'
if [ -z $* ];then
    echo "未输入版本参数 $tips"
elif [ "$*" == 'fast' ];then 
    v_fast
elif [ "$*" == 'full' ];then
    v_full
elif [ "$*" == 'product' ];then
    v_product
elif [ "$*" == 'update' ];then
    installConfigFile
elif [ "$*" == 'restore' ];then
    uninstallConfigFile
elif [ "$*" == 'cleanbackup' ];then
    cleanBackup
elif [ "$*" == 'fix' ];then
    fixbashrc
else
    echo "不正确的参数 $tips"
fi
