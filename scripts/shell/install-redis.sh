#!/bin/sh

wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz && rm -rf redis-stable.tar.gz
cd redis-stable
make && make install && cd .. && rm -rf redis-stable
