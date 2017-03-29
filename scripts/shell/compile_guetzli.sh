#!/bin/bash

name='guetzli'
zipfile="${name}.zip"

sudo apt-get install libpng-dev libgflags-dev -y
[ -f $zipfile ] || curl https://github.com/google/guetzli/archive/master.zip > $zipfile
[ -d $name-master ] || unzip -o $name
cd $name-master
make && sudo mv ./bin/Release/guetzli /usr/local/bin &&
	cd .. && rm -rf $name-master $zipfile
