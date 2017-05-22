#!/bin/sh

wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz && rm -rf redis-stable.tar.gz
cd redis-stable
make && sudo make install && \
        sudo cp redis.conf /etc/redis.conf && \
        sudo cp redis.conf /etc/redis.conf.example && \
        cd .. && rm -rf redis-stable
