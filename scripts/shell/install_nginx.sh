#!/bin/bash
# https://www.nginx.com/resources/admin-guide/installing-nginx-open-source/

function install_pcre(){
	pcre_name=pcre-8.39
	if [ ! -d $pcre_name ]; then
		if [ ! -f $pcre_name.tar.gz ]; then
			wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$pcre_name.tar.gz
		fi
		tar -zxf $pcre_name.tar.gz
		#cd $pcre_name && ./configure && make && sudo make install && cd ..
	fi
}

function install_zlib(){
	zlib_name=zlib-1.2.11
	if [ ! -d $zlib_name ]; then
		if [ ! -f $zlib_name.tar.gz ]; then
			wget http://zlib.net/$zlib_name.tar.gz
		fi
		tar -zxf $zlib_name.tar.gz
		#cd $zlib_name && ./configure && make && sudo make install && cd ..
	fi
}

function install_openssl(){
	ssl_name='openssl-1.0.2g'
	if [ ! -d $ssl_name ]; then
		if [ ! -f $ssl_name.tar.gz ]; then
			wget https://openssl.org/source/$ssl_name.tar.gz
		fi
		tar -zxf $ssl_name.tar.gz
	fi
}

function get_nginx(){
	if [ ! -d nginx-1.10.2 ]; then
		if [ ! -f nginx-1.10.2.tar.gz ]; then
			wget http://nginx.org/download/nginx-1.10.2.tar.gz
		fi
		tar zxf nginx-1.10.2.tar.gz
	fi
}

function install_nginx(){
	get_nginx
	# google proxy
	git clone https://github.com/cuber/ngx_http_google_filter_module 2>/dev/null
	git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module 2>/dev/null
	git clone https://github.com/openresty/headers-more-nginx-module.git 2>/dev/null

	cd nginx-1.10.2
	echo ">>> Current directory: $(pwd)"

	./configure \
		--prefix=/usr/local/nginx \
		--sbin-path=/usr/local/nginx/nginx \
		--conf-path=/usr/local/nginx/nginx.conf \
		--pid-path=/usr/local/nginx/nginx.pid \
		--user=nginx \
		--group=nginx \
		--with-cc-opt="-D FD_SETSIZE=2048" \
		--with-pcre=../$pcre_name \
		--with-zlib=../$zlib_name \
		--with-openssl=../$ssl_name \
		--with-stream \
		--with-stream_ssl_module \
		--with-http_ssl_module \
		--with-http_v2_module \
		--with-ipv6 \
		--with-http_realip_module \
		--with-http_sub_module \
		--with-http_addition_module \
		--with-threads \
		--with-file-aio \
		--with-http_stub_status_module \
		--add-module=../ngx_http_google_filter_module \
		--add-module=../ngx_http_substitutions_filter_module \
		--add-module=../headers-more-nginx-module \
		--with-debug &&
		make && make install
}

if ! which git &>/dev/null ; then
	echo 'Please install [git] first!'
	exit 1
fi
install_pcre &&
	install_zlib &&
	install_openssl &&
	install_nginx
