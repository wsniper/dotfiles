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
PROXY=127.0.0.1:1080

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
alias ll='ls -lFh'
alias la='ls -A'
alias l='ls -CF'

# git
alias gitup="git add -A; git commit -m"
alias gitconf="vi .git/config"
function getgitignore(){
    wget https://raw.githubusercontent.com/github/gitignore/master/$1.gitignore -O .gitignore
}

# change directory
alias cd=cdls
function cdls() {
    builtin cd "$@" && ls -F
    echo $(pwd) > ~/.last
}
function backwork(){
    cd $(cat ~/.last)
}
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias home="cd ~"
alias dload="cd ~/download"
alias github="cd ~/github"
alias conf="cd /root/conf"

# monitoring system
alias df="df -h"
alias lscon="netstat -ntu | awk 'NR>2 {print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr"
alias lsf="ls -ahlS | grep -v ^d"
alias lsport="netstat -apn | grep $1"
alias updatetime="ntpdate asia.pool.ntp.org"
function http(){
    if [ -z $1 ]; then
        port=8080
    else
        port=$1
    fi
    if [ ${port} -lt 1024 ]; then
        sudo python -m SimpleHTTPServer ${port}
    else
        python -m SimpleHTTPServer ${port}
    fi
}

# other
alias v="vim"
alias vi="vim"
alias rm="rm -i"
alias f5="source ~/.bashrc"
alias freemem="echo 1 > /proc/sys/vm/drop_caches"
alias useproxy="export http_proxy=${PROXY};export https_proxy=${PROXY};"
alias noproxy="unset http_proxy https_proxy"

# VPS
#unix bench
alias unixbench="wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh && chmod +x unixbench.sh && ./unixbench.sh"
#rebuilt sphinx
alias upblog="cd /www/blogger;git pull;hugo;cd -"
#use 'make livehtml' to replace it
alias rebuild="cd ../..;make html;cd -;python -m SimpleHTTPServer"

# golang env
export GOROOT=/usr/local/go
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
alias cdgo="cd $GOPATH"
alias installgopm="go get -u github.com/gpmgo/gopm"

# docker
# docker daemon with proxy
alias ddp="http_proxy=${PROXY} docker daemon"
alias ddnp="unset http_proxy https_proxy; docker daemon"
# 杀死所有正在运行的容器.
alias dockerkill='docker kill $(docker ps -a -q)'
# # 删除所有已经停止的容器.
alias dockercleanc='docker rm $(docker ps -a -q)'
# # 删除所有未打标签的镜像.
alias dockercleani='docker rmi $(docker images -q -f dangling=true)'
# # 删除所有已经停止的容器和未打标签的镜像.
alias dockerclean='dockercleanc || true && dockercleani'

# net
alias getsite="wget -r -k -p -np"
alias installdocker="wget -O- https://get.docker.com/ | sh"
# install from daocloud.io
alias installdaocker="curl -sSL https://get.daocloud.io/docker | sh"
# add backports to apt repo on debian wheezy
wheezybackports='deb http://ftp.de.debian.org/debian wheezy-backports main'
alias installsspy="wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh && chmod +x shadowsocks.sh && ./shadowsocks.sh 2>&1 | tee shadowsocks.log"
alias installssgo="wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-go.sh && chmod +x shadowsocks-go.sh && ./shadowsocks-go.sh 2>&1 | tee shadowsocks-go.log"
alias installssr="wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh && chmod +x shadowsocksR.sh && ./shadowsocksR.sh 2>&1 | tee shadowsocksR.log"

function installpip(){
    if [ ! -e 'get-pip.py' ]; then
        wget https://bootstrap.pypa.io/get-pip.py
    fi
    if [ -z $1 ]; then
        version='2'
    else
        version=$1
    fi
    sudo "python${version}" ./get-pip.py
}

function installnode(){
    node_dir=/usr/local/node
    if [ -e $node_dir ]; then
        read -p "${node_dir} existed, remove it permanently and reinstall? [yes/NO]" remove
        if [ $remove = 'yes' ]; then
            sudo rm -rf $node_dir
        elif [ $remove = 'no' ]; then
            return 1
        fi
    fi

    if [ -z $1 ]; then
        version='64'
    else
        version='86'
    fi

    if [ ! -e node*.xz ]; then
        wget https://nodejs.org/dist/v4.5.0/node-v4.5.0-linux-x${version}.tar.xz
    fi
    sudo tar xf node*.tar.xz -C /usr/local && sudo mv ${node_dir}* ${node_dir}
    cmd='export PATH=$PATH:/usr/local/node/bin'
    sudo sh -c "echo '$cmd' >> /etc/profile"
    export PATH=$PATH:/usr/local/node/bin
    echo 'Finish!'
}

# npm
alias npmtaobao="npm config set registry https://registry.npm.taobao.org"
alias npmofficial="npm config delete registry"
function npmls(){
    npm ls --depth 0 $@
}

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
