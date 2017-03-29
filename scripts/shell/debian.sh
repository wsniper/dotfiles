#!/bin/bash
# ONLY FOR Debian serises system!

# start from here
sudo apt update && sudo apt upgrade
sudo apt install vim git tree htop tmux -y

# build basic
sudo apt install gcc g++ build-essential -y

# optional: only for vim
sudo apt install vim-gtk exuberant-ctags -y

# for python2 dev
sudo apt install python-dev python-pip -y
sudo pip install -U pip
sudo pip install setuptools
sudo pip install requests supervisor flask tornado

# for python3 dev
sudo apt install python3-dev python3-pip -y
sudo pip3 install -U pip
sudo pip3 install setuptools


# === VPS special ===
cd ~
mkdir Downloads src
cd src && git clone https://github.com/weaming/linuxrc && cd linuxrc && yes | bash install.sh product