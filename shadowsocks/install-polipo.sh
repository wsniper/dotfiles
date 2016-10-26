#!/usr/bin/env bash
# 转换sock代理为http代理
# [为终端设置Shadowsocks代理](http://droidyue.com/blog/2016/04/04/set-shadowsocks-proxy-for-terminal/index.html)
# 运行成功后，设置ｂａｓｈ环境变量 http_proxy 为 localhost:8123

sudo apt-get install polipo &&
    sudo sh -c 'cat ./polipo.config >> /etc/polipo/config' &&
    sudo service polipo restart && echo 'Restart service success!'

echo '运行成功后，设置ｂａｓｈ环境变量 http_proxy 为 localhost:8123'
echo '然后运行 curl ip.gs 进行测试'
