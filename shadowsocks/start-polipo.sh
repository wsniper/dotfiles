#!/bin/bash
# start polipo in background process. If it's running, will be killed and restart new.

function start(){
	sudo polipo -c /etc/polipo/config
}

function restart(){
	pid=$( pgrep -u root polipo )
	[ "$pid" ] && sudo kill "$pid" 2>/dev/null && echo "Process $pid has been killed."

	start && sleep 1
	newpid=$( pgrep -u root polipo )
	echo "Restarted with PID $newpid"
}

restart
