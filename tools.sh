#!/bin/bash

# -------------------------------------------------------------------
# Safety
# -------------------------------------------------------------------
alias addSSHKey='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa'
function newSSHKey(){
	[ -z "$1" ] && echo 'Please provide key comment text' && return 1;
    ssh-keygen -t rsa -b 4096 -C $1 && eval "$(ssh-agent -s)"

    echo "To add private key: ssh-add ~/.ssh/id_rsa"
    pubkey="$HOME/.ssh/id_rsa.pub"
    [ -f "$pubkey" ] && echo "You public key:" && cat $pubkey
}


function gencert() {
    [ "$1" = "" ] && echo "Please provide your domain" && return 1
    DOMAIN="$1"
    echo "Create server key..."
    openssl genrsa -out $DOMAIN.key 2048

    echo "Create server certificate signing request..."
    SUBJECT="/C=US/CN=$DOMAIN"
    openssl req -new -subj $SUBJECT -key $DOMAIN.key -out $DOMAIN.csr

    echo "Sign SSL certificate..."
    openssl x509 -req -days 3650 -in $DOMAIN.csr -signkey $DOMAIN.key -out $DOMAIN.crt

    echo "\nTODO:"
    echo "Copy $DOMAIN.crt to /etc/nginx/ssl/$DOMAIN.crt"
    echo "Copy $DOMAIN.key to /etc/nginx/ssl/$DOMAIN.key"
    echo "Add configuration in nginx:"
    echo "server {"
    echo "    ..."
    echo "    listen 443 ssl;"
    echo "    ssl_certificate     /etc/nginx/ssl/$DOMAIN.crt;"
    echo "    ssl_certificate_key /etc/nginx/ssl/$DOMAIN.key;"
    echo "}"
}


# other script
alias weather="~/scripts/python/weather.py"
alias youdao="~/scripts/python/youdao.py"
alias redemo="~/scripts/python/redemo.py"

# change color temperature with redshift
alias protecteye='nohup redshift -l 22.5431:114.0579 &>/dev/null &'

# -------------------------------------------------------------------
# VPS
# -------------------------------------------------------------------
#unix bench
alias unixbench="wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh && chmod +x unixbench.sh && ./unixbench.sh"

# simple install
alias installdocker="wget -O- https://get.docker.com/ | sh"

alias installsspy="wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh && chmod +x shadowsocks.sh && ./shadowsocks.sh 2>&1 | tee shadowsocks.log"
alias installssgo="wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-go.sh && chmod +x shadowsocks-go.sh && ./shadowsocks-go.sh 2>&1 | tee shadowsocks-go.log"
alias installssr="wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh && chmod +x shadowsocksR.sh && ./shadowsocksR.sh 2>&1 | tee shadowsocksR.log"
