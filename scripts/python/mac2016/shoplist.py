#!/usr/bin/python
# coding: utf-8
"""
Author       : weaming
Created Time : 2016-12-07 22:06:44

File Name    : shoplist.py
Description  :
    _recurse: 递归
    _key: JSON Key值
    _properties: 属性列表
    _nullable: 是否允许留空
    _default: 不留空情况下的默认值
    _func: 输入字符串的处理函数
"""
from os.path import isfile
import sys
import json
try:
    from collections import OrderedDict
except:
    from ordereddict import OrderedDict


basestring = (str, unicode)
input = raw_input if sys.version_info.major == 2 else input

prefix = []


class NullError(Exception):
    pass


def __(metadata):
    global prefix
    rv = OrderedDict()
    for p_name in metadata['_properties']:
        p = metadata.get(p_name, None)
        if p is None:
            continue
        p_key = p.get('_key', p_name)

        if '_properties' in p:
            # container
            prefix.append(p_name)
            rv[p_key] = process(p)
            prefix.pop()
        else:
            # true property
            func = p.get('_func', None)
            rv[p_key] = checked_input(func, '%s => %s: ' % (' > '.join(prefix), p_name),
                                      p.get('_nullable', True),
                                      p.get('_default', None))
    return rv


def checked_input(func, prompt, nullable=False, default=None):
    try:
        raw_value = input(prompt)
        if not nullable and not raw_value:
            if default is None:
                raise NullError
            else:
                raw_value = default

        if func is None:
            value = raw_value.decode('utf8')
        else:
            value = func(raw_value)
        return value
    except ValueError:
        print('Value Error: must be %s' % func)
        return checked_input(func, prompt)
    except NullError:
        print('Value is not nullable!')
        return checked_input(func, prompt)
    except KeyboardInterrupt:
        sys.exit(2)


def process(metadata):
    if metadata.get('_recurse', False):
        rv = []
        while True:
            rv.append(__(metadata))
            finish = input('%s => %s' % (' > '.join(prefix), 'Finish?[y/N]:')).lower() == 'y' or False
            if finish:
                break
        return rv
    else:
        return __(metadata)


if __name__ == '__main__':
    metadata = {
        '_recurse': True,
        '_properties': ['date', 'platform', 'items'],
        'date': {
            '_key': 'date',
        },
        'platform':{
            '_nullable': False,
        },
        'items': {
            '_recurse': True,
            '_properties': ['name', 'url', 'qty', 'price'],
            'name': {
                '_nullable': False,
            },
            'url': {},
            'qty': {
                '_func': int,
                '_nullable': False,
                '_default': 1,
            },
            'price': {
                '_func': float,
                '_nullable': False,
            },
        }
    }

    file_name = 'result.json'
    origin = []
    if isfile(file_name):
        with open(file_name, 'r') as f:
            try:
                origin = json.loads(f.read())
            except:
                pass

    result = process(metadata)
    origin += result

    with open('result.json', 'w') as f:
        f.write(json.dumps(origin, ensure_ascii=False, indent=4).encode('utf8'))
        f.write('\n')


