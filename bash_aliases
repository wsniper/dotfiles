# by weaming
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

########
#d 目录
#- 普通文件
#l 符号链接
#s 套接字文件
#b 块设备文件
#c 字符设备文件
#p 命名管道文件
################

# Check OS
function checkos(){
    OS=unknown
    if [ -f /etc/redhat-release ];then
        OS=CentOS
    elif [ ! -z "`cat /etc/issue | grep bian`" ];then
        OS=Debian
    elif [ ! -z "`cat /etc/issue | grep Ubuntu`" ];then
        OS=Ubuntu
    else
        echo "Not support OS, Please reinstall OS and retry!"
        exit 1
    fi
    echo "The System is $OS"
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# git
alias gitup="git add -A; git commit -m"
alias gitconf="vi .git/config"

# change directory
alias cd=cdls
function cdls() {
    builtin cd "$@" && ls -F
}
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias home="cd ~"
alias dload="cd ~/download"
alias github="cd ~/github"
alias conf="cd /root/conf"

# monitoring system
alias lscon="netstat -ntu | awk 'NR>2 {print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr"
alias lsf="ls -ahlS | grep -v ^d"
alias lsport="netstat -apn | grep $1"

# other
alias v="vim"
alias vi="vim"
alias rm="rm -i"
alias df="df -h"
alias f5="source ~/.bashrc"
alias freemem="echo 1 > /proc/sys/vm/drop_caches"
alias useproxy="export http_proxy=127.0.0.1:1080;export https_proxy=127.0.0.1:1080;"
alias noproxy="export http_proxy=;export https_proxy=;"

# VPS
#rebuilt sphinx
alias upblog="cd /www/blogger;git pull;hugo;cd -"
# use make livehtml to replace
alias rebuild="cd ../..;make html;cd -;python -m SimpleHTTPServer"

# golang env
export GOROOT=/usr/local/go
export GOPATH=~/go/
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
alias cdgo="cd $GOPATH"
alias installgopm="go get -u github.com/gpmgo/gopm"

# net
alias getsite="wget -r -k -p -np"
alias installdocker="wget -O- https://get.docker.com/ | sh"
# install from daocloud.io
alias installdaocker="curl -sSL https://get.daocloud.io/docker | sh"
# add backports to apt repo on debian wheezy
wheezybackports='deb http://ftp.de.debian.org/debian wheezy-backports main'

# npm
alias npmtaobao="npm config set registry https://registry.npm.taobao.org"
alias npmofficial="npm config delete registry"

# OS depend
if [ "$OS" == 'CentOS' ]; then
    alias yumi="sudo yum install"
    alias update="sudo yum update"
fi
if [ "$OS" == 'Debian' ] || [ "$OS" == 'Ubuntu' ]; then
    alias apti="sudo apt-get install"
    alias update="sudo apt-get update"
fi
if [ "$OS" == 'Ubuntu' ]; then
    alias files="sudo nautilus"
fi

# files
alias vimrc="vim ~/.vimrc"
alias aliases="vim ~/.bash_aliases"
alias bashrc="vim ~/.bashrc"

# shell
alias iss="~/shell/ss.sh"
alias isync="~/shell/isync.sh"
alias iwt="~/shell/weather.py"

# 美化
export PS1="\[\033[38;5;208m\]\t\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;251m\]\$?\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;27m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;253m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;2m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\[$(tput sgr0)\]\[\033[38;5;226m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

# 增加动态性配置
if [ -f ~/.userrc ]; then
    . ~/.userrc
fi
