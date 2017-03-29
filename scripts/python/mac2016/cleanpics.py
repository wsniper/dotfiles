#!/usr/bin/env python
# coding: utf-8
"""
Author       : weaming
Created Time : 2016-12-06 00:51:08

File Name    : cleanpics.py
Description  :
    My downloaded picture archive tool.
"""
import os
import shutil
from filetree import File

dirs = [
    'io',
]

cwd = os.path.expanduser('~/Downloads')
os.chdir(cwd)
F = File(cwd)


def twitter_large(F):
    for f in F.files:
        if f.basename.lower().endswith('-large'):
            print f.basename
            shutil.move(f.path, f.path[:-6])


def archive(path, prefix=None, suffix=None):
    archive_dir = os.path.abspath(path)
    if not os.path.isdir(archive_dir):
        os.makedirs(archive_dir)

    for f in F.files:
        if (prefix and f.basename.startswith(prefix)) or suffix and f.basename.endswith(suffix):
            print f.path
            try:
                shutil.move(f.path, archive_dir)
            except:
                print('fail move: %s' % f.path)


def tumblr_archive(F):
    archive('io/tumblr/', prefix='tumblr_')


def bing_archive(F):
    archive('Images/Bing', prefix='BingWallpaper')

def garea_archive(F):
    archive('io/g-area', prefix='pg_')

def pdf(F):
    archive('PDF', suffix='.pdf')

def tgz(F):
    archive('TAR', suffix='.tgz')
    archive('TAR', suffix='.tbz')
    archive('TAR', suffix='.tar.gz')

def main(funcs, dirs):
    # 当前目录
    map(lambda x: x(F), funcs)
    for f in F.images:
        shutil.move(f.path, 'Images')

    # 子文件夹
    for d in F.dirs:
        if d.basename in dirs:
            map(lambda x: x(d), funcs)


if __name__ == '__main__':
    main([tumblr_archive, bing_archive, twitter_large, garea_archive, pdf, tgz], dirs)

