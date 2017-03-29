#!/bin/sh
# must run as root

nginx=tengine  # or whatever your webserver is

$nginx -s stop && \
    /root/letsencrypt/letsencrypt-auto renew -nvv --force-renewal --standalone > /var/log/letsencrypt/renew.log 2>&1

LE_STATUS=$?
$nginx # or whatever your webserver is
if [ "$LE_STATUS" != 0 ]; then
    echo Automated renewal failed:
    cat /var/log/letsencrypt/renew.log
    exit 1
fi
