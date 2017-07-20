#!/usr/bin/env bash

# 必须以root用户运行
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# 安装pip并安装python版SS
apt-get install python-pip -y
pip install shadowsocks

# SS配置模板
cat > /etc/shadowsocks.json <<EOF
{
    "server":"YOUR SERVER/IP",
    "server_port":8080,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"YOUR PASSWORD",
    "timeout":600,
    "method":"aes-256-cfb",
    "fast_open": false
}
EOF

# 启动SS
sslocal -c /etc/shadowsocks.json -d start &&
	echo "Shadowsocks client started with PID $(pgrep sslocal)"

# polipo: 转换sock代理为http代理
apt-get install polipo
    service polipo restart 2>/dev/null && echo 'Restart polipo service success!'

# 配置polipo
cat > /etc/polipo/config <<EOF
socksParentProxy = "localhost:1080"
socksProxyType = socks5
proxyAddress = "0.0.0.0"
daemonise = true
EOF

# 启动polipo的脚本
startplp=/usr/local/bin/startplp
cat > $startplp <<EOF
#!/bin/bash
# start polipo in background process. If it's running, will be killed and restart new.

function start(){
	sudo polipo -c /etc/polipo/config
}

function restart(){
	pid=\$(pgrep polipo)
	[ "\$pid" ] && sudo kill \$pid 2>/dev/null && echo "Polipo with PID \$pid has been killed."

	start && sleep 1
	newpid=\$(pgrep polipo)
	echo "Polipo restarted with PID \$newpid"
}

restart
EOF

chmod a+x $startplp && $startplp

echo ''
echo '========================================================='
echo ''
echo 'sudo vi /etc/shadowsocks.json 编辑配置信息'
echo 'sudo sslocal -c /etc/shadowsocks.json -d restart 重启SS'
echo '运行成功后，设置bash环境变量 http_proxy 为 localhost:8123'
echo '运行 startplp 来启动/重启 polipo'
echo '然后运行 curl ip.gs 进行测试'
