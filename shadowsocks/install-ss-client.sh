#!/usr/bin/env bash

sudo pip install shadowsocks

echo 
echo 'Shadowsocks安装已完成!'

sudo cp ./shadowsocks.json /etc/sb.json
sudo cp ./fuckgfw.sh /usr/local/bin/fuckgfw
sudo chmod a+x /usr/local/bin/fuckgfw

echo '安装完成！fuckgfw 启动，fuckgfw uninstall 卸载。'
