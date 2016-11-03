# Shadowsocks

## Client: install-ss-client.sh

Install ss client.

### fuckgfw.sh

Start shadowsocks in background or `sh fuckgfw.sh uninstall` to uninstall python version ss.

### install-polipo.sh

转换sock代理为http代理。 [为终端设置Shadowsocks代理](http://droidyue.com/blog/2016/04/04/set-shadowsocks-proxy-for-terminal/index.html)

运行成功后，设置ｂａｓｈ环境变量 `http_proxy` 为 `localhost:8123`

## Server

### install-kcptun.sh

    wget https://raw.githubusercontent.com/weaming/linuxrc/master/shadowsocks/install-kcptun.sh -O- | sh

