#!/bin/bash

apt-get install exuberant-ctags vim ctags
echo -e "安装git vim ctags完成...\n"
cp ./vimrc ~/.vimrc
echo -e "复制.vimrc完成...\n"
cat ./fixbashrc >> ~/.bashrc
cp ./bash_aliases ~/.bash_aliases
source ~/.bashrc
echo -e "复制.bash_aliases完成...\n"
git clone https://github.com/weaming/shell.git ~/shell
echo -e "迁移shell工具完成...\n"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo -e "安装vundle.vim插件管理完成...\n"
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

echo "配置git完成..."
echo -e "------Success------\n"
echo "完成之后打开vim执行‘BundleInstall’命令安装vim插件"

