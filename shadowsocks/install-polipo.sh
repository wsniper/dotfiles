#!/usr/bin/env bash
# 转换sock代理为http代理
# [为终端设置Shadowsocks代理](http://droidyue.com/blog/2016/04/04/set-shadowsocks-proxy-for-terminal/index.html)
# 运行成功后，设置ｂａｓｈ环境变量 http_proxy 为 localhost:8123

sudo apt-get install polipo &&
    sudo service polipo restart 2>/dev/null && echo 'Restart service success!'

sudo cp ./polipo.config /etc/polipo/config &&
sudo cp ./start-polipo.sh /usr/local/bin/start-polipo &&
sudo chmod a+x /usr/local/bin/start-polipo

echo '运行成功后，设置ｂａｓｈ环境变量 http_proxy 为 localhost:8123'
echo '然后运行 curl ip.gs 进行测试'
echo '运行 start-polipo 来启动/重启 polipo'
