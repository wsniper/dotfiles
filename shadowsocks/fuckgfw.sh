#!/usr/bin/env bash

if [ "$*" == "uninstall" ]; then
	sudo pip uninstall shadowsocks
	sudo rm -f /usr/local/bin/fuckgfw
else
	pid="$(sudo pgrep sslocal)"
	[ "$pid" ] && sudo pkill sslocal && echo "killed $pid"
	sudo sslocal -c /etc/shadowsocks.json -d start &&
		echo "started with PID $(sudo pgrep sslocal)"
fi
