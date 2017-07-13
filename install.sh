#!/bin/bash
# 只备份vimrc和bash_aliases；如果已存在备份文件，则跳过，即只备份最初的

work=~/.
new=./

var=vimrc
workVimrc=${work}${var}
newVimrc=${new}${var}
bakVimrc=${work}${var}.bak

var=bash_aliases
workBashAlias=${work}${var}
newBashAlias=${new}${var}
bakBashAlias=${work}${var}.bak

installBasicSoftware(){
    if which sudo &> /dev/null; then
        echo '安装将花费一定时间，请耐心等待直到安装完成^_^'
        echo

        if which apt-get &> /dev/null; then
            sudo apt-get install -y git exuberant-ctags vim-gtk
        elif which yum &> /dev/null; then
            sudo yum install -y git ctags vim-gtk
        elif which brew &> /dev/null; then
            brew install -y git ctags macvim
        fi
        echo ">> 安装git vim ctags完成!"
    else
        echo ">> 未知系统，请手动安装git vim ctags!"
    fi
    cp ${new}bashmarks.sh ${work}bashmarks.sh
}

fixbashrc(){
    cat ./fixbashrc >> ~/.bashrc
    echo '已修复 ~/.bash_aliases 无效的问题:)'
}

installVundleVim(){
    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        echo ">> 安装vundle.vim插件管理完成!"
    else
        echo ">> vundle.vim插件管理已存在!"
    fi
    echo "weaming正在努力为您安装bundle程序" > weaming
    echo "安装完毕将自动退出" >> weaming
    echo "请耐心等待" >> weaming
    vim weaming -c "PluginInstall" -c "q" -c "q"
    rm -f weaming
    echo ">> 安装VIM插件完成!"
}

installFileCommon(){
    if [ ! -f $bakBashAlias ];then
        cp -f $workBashAlias $bakBashAlias 2>/dev/null
        echo "已备份: ${bakBashAlias}"
    fi
    cp $newBashAlias $workBashAlias && echo ">> 复制.bash_aliases完成!"

    cp ./zsh/zsh_aliases ~/.zsh_aliases && echo ">> 复制.zsh_aliases完成!"
    cp ./aliases ~/.aliases && echo ">> 复制.aliases完成!"
    cp ./npmrc ~/.npmrc && echo ">> 复制.npmrc完成!"
}

installVimrc(){
    if [ ! -f $bakVimrc ];then
        cp $workVimrc $bakVimrc 2>/dev/null && echo "已备份: ${bakVimrc}"
    fi

    if [ -z $1 ];then
        tmp=$newVimrc
    else
        tmp=$1
    fi

    echo ">> Using $tmp"
    cp $tmp $workVimrc && echo ">> 复制 ${tmp} 完成!"
}

cleanBackup(){
    files="$bakBashAlias $bakVimrc"
    rm -f $files && echo "已删除 $files"
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

    git config --global color.status auto
    git config --global color.branch auto
    git config --global color.interactive auto
    git config --global color.diff auto
    git config --global push.default current
    #git config --global push.default simple

    git config --global core.filemode false
    git config --global core.autocrlf input

    git config --global alias.back 'reset --hard HEAD^'
    git config --global alias.unstage 'reset HEAD'
    git config --global alias.last 'log -1'
    git config --global alias.logg 'log --graph --pretty=oneline --abbrev-commit'

    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

    git config --global core.editor vim
    git config --global merge.tool vimdiff
    git config --global http.postBuffer 157286400

    configGitUser

    echo "配置git完成!"
}

function echoHelp() {
    echo '"source ~/.bashrc" if your are using bash;'
    echo '"source ~/.zshrc" if your are using zsh;'
    echo 'if not work, "bash install.sh fix" first!'
}

################### 版本管理 #############
v_common(){
    installBasicSoftware
    configGit
    installFileCommon
}

v_product(){
    # 精简版vimrc
    v_common
    installVimrc ./vimrc.lite
    installVundleVim
    echoHelp
}

v_full(){
    v_common
    installVimrc $newVimrc
    installVundleVim
    echoHelp
}

v_update(){
    installFileCommon
    installVimrc
    echo 'Now you can use command "f5" to refresh settings!'
}

case "$1" in
    full|product|update)
        v_$1
        ;;
    fix)
        fixbashrc
        ;;
    vundle)
        installVundleVim
        ;;
    basicSoftware)
        installBasicSoftware
        ;;
    *)
        tips='{full|product|update|vundle|basicSoftware|fix|cleanbackup}'
        echo "Usage: bash $0 $tips"
        exit 1
esac

