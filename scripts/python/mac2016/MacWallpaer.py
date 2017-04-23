#!/usr/bin/env python
# coding: utf-8
"""
Author       : weaming
Created Time : 2017-02-08 23:00:58

File Name    : archive.py
Description  :
    Download Bing.com today wallpaper and set it as computer desktop wallpaper.
"""
import os
from filetree import File

root = os.path.expanduser('~/Downloads/BingWallpapers')
to = 'archived'

def download():
    os.system("%s -t" % os.path.expanduser('~/go/bin/bingwptoday'))

def archive_and_set_wp():
    F = File(root)
    pics = sorted(F.images, lambda x, y: cmp(x.ctime, y.ctime))
    if len(pics) > 1:
        for x in pics[:-1]:
            print x
            x.move_to(os.path.join(root, to))

        set_wallpaper(pics[-1].path)

def set_wallpaper(path):
    os.system("""sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '%s'" && killall Dock""" % path)

if __name__ == '__main__':
    download()
    archive_and_set_wp()
