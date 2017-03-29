#!/usr/bin/env python
# coding: utf-8
# convert base64 encoed gfwlist to plain text

import urllib
import base64

url = 'https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt'
print('Start connect...')
f = urllib.urlopen(url)
origin = f.read()
print('Donwloaded!')

decrypt = base64.b64decode(origin)
with open('gfwlist.txt', 'w') as txt:
    txt.write(decrypt)
print('Done!')

