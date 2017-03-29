#!/bin/bash

curl https://unix4lyfe.org/gitweb/darkhttpd/blob_plain/HEAD:/darkhttpd.c -O &&
	gcc darkhttpd.c -o darkhttpd &&
	rm -f darkhttpd.c &&
	sudo mv darkhttpd /usr/local/bin/darkhttpd && 
	echo 'Finished!' || echo 'Build success but fail move to /usr/local/bin/'
