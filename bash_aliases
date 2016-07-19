# by weaming
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi
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

# directory
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

# other
alias vi="vim"
alias rm="rm -i"
alias df="df -h"
alias upblog="cd /www/;hugo;cd -"
alias f5="source ~/.bashrc"
alias freemem="echo 1 > /proc/sys/vm/drop_caches"
alias useproxy="export http_proxy=127.0.0.1:1080;export https_proxy=127.0.0.1:1080;"
alias noproxy="export http_proxy=;export https_proxy=;"
alias rebuild="cd ../..;make html;cd -;python -m SimpleHTTPServer"

# golang env
export GOROOT=/usr/local/go
export GOPATH=~/go/
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
alias cdgo="cd $GOPATH"
alias installgopm="go get -u github.com/gpmgo/gopm"

# net
alias getsite="wget -r -k -p -np"
alias installdocker="curl -sSL https://get.daocloud.io/docker | sh"

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
