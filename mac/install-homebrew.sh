#########################################################################
# File Name: install-homebrew.sh
# Author: weaming
# mail: garden.yuen@gmail.com
# Created Time: 2016-12-14 00:51:05
#########################################################################
#!/bin/bash

if ! which git &>/dev/null ; then
    echo 'Please install [git] first!'
    exit 1
fi

if ! `which brew &>/dev/null` ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

# homebrew
cd "$(brew --repo)" && git remote set-url origin git://mirrors.ustc.edu.cn/brew.git

# homebrew-core
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" && git remote set-url origin git://mirrors.ustc.edu.cn/homebrew-core.git

# homebrew-cask
brew tap caskroom/cask &&
    cd "$(brew --repo)/Library/Taps/caskroom/homebrew-cask" && git remote set-url origin git://mirrors.ustc.edu.cn/homebrew-cask.git

# homebrew-bottles
ENV_STR='export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles'
#if [ `echo $SHELL | grep -q zsh` ]; then
#echo $ENV_STR >> ~/.zshrc
#source ~/.zshrc
#else
#echo $ENV_STR >> ~/.bash_profile
#source ~/.bash_profile
#fi
echo "================================================="
echo "Please add \"$ENV_STR\" to your shell start file:"
echo "~/.zshrc or ~/.bash_profile or other if you know what you are doing :)"
echo "================================================="

