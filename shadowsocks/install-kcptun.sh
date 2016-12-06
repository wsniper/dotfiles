#!/usr/bin/env sh

if [ -n "$1" ]; then
    platform=$1
else
    platform='64'
fi

version='20161102'
base_url="https://github.com/xtaci/kcptun/releases/download/v${version}/"

declare -A urls
urls=(
    ['32']="kcptun-linux-386-${version}.tar.gz"
    ['64']="kcptun-linux-amd64-${version}.tar.gz"
)

name=${urls[$platform]}
if [[ ! -d /usr/local/kcptun ]]; then
    if [ ! -f $name ]; then
        echo "Downloading: $name"
        wget "$base_url$name" 2>/dev/null -O $name
    fi

    if [ ! -d 'kcptun' ]; then
        mkdir kcptun
    fi
    tar xf $name -C kcptun && rm -f $name

    sudo mv kcptun /usr/local/ && sudo ls /usr/local/kcptun
fi

sudo ln -s /usr/local/kcptun/client_linux_amd64 /usr/local/bin/kcptun-client &&
sudo ln -s /usr/local/kcptun/server_linux_amd64 /usr/local/bin/kcptun-server
