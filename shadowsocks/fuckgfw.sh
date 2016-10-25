#!/usr/bin/env bash

if [ "$*" == "uninstall" ]; then
    sudo pip uninstall shadowsocks
    sudo rm -f /usr/local/bin/fuckgfw
else
    sudo sslocal -c /etc/shadowsocks.json -d start
fi
