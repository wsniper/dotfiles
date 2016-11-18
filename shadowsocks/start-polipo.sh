#!/bin/sh
# start polipo in background process. If it's running, will be killed and restart new.

function start(){
    dir=/var/log/polipo
    log=$dir/error.log
    [ ! -d $dir ] && sudo mkdir -p $dir
    [ ! -w $dir ] && sudo chmod a+rwx $dir
    nohup polipo -c /etc/polipo/config >/dev/null 2>$log &
}

function running(){
    cat $log

    pid=$(ps aux | grep polipo | awk '$11=="polipo"{print $2}')
    sudo kill $pid 2>/dev/null &&
    echo "Process $pid has been killed."

    rm -f $log
    start
    sleep 1
    newpid=$(ps aux | grep polipo | awk '$11=="polipo"{print $2}')
    echo "Restarted with PID $newpid"
}

start
sleep 1
[ -f $log ] && running

