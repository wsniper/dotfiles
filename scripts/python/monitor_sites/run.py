#!/usr/bin/env python
# coding: utf-8

import time
import requests
from datetime import datetime as dt
from imail import send_mail as emailer


TIME_FORMAT = r'%Y-%m-%d %X'
DELAY = 30
TIMEOUT = 3

def log(txt, type='Log'):
    print('[{: ^11}] {}: {}'.format(type, dt.now().strftime(TIME_FORMAT), txt))

def try_get(url, func=lambda x: 'http://' + x if not x.lower().startswith('http') else x):
    _url = func(url)
    log('Trying: %s' % _url)

    try:
        res = (url, requests.get(_url, timeout=TIMEOUT))
    except requests.exceptions.Timeout:
        res = (url, 'Timeout')
    except requests.exceptions.ConnectionError:
        res = (url, 'ConnectionError')
    except Exception as e:
        res = (url, e)
    return res

def callback(response):
    """
    status:
        0 ok, alive
        1 to be warning
        2 dead, to be made alive, no warning
    """
    if not hasattr(callback, '_status'):
        callback._status = {}
    x = callback._status

    url, res = response

    if isinstance(res, requests.Response):
        x[url] = {
            'status': 0,
            'res': res
        }
    else:
        if url in x and x[url]['status'] == 1:
            x[url] = {
                'status': 2,
                'res': res
            }
        else:
            x[url] = {
                'status': 1,
                'res': res
            }

def send_mail(text):
    #log(text, type='WARNING')
    receiver = ['garden.yuen@gmail.com', 'iweaming@gmail.com']
    sender = 'ruanjiadeng@foxmail.com'

    server_info = {
        'server': 'smtp.qq.com',
        'username': 'ruanjiadeng@foxmail.com',
        'password': 'bhiaxubkmwmebced',
        'ssl': True,
    }
    #server_info = {
        #'server': '192.168.42.14',
    #}
    emailer(text, sender, receiver, subject="Test", server=server_info)


def main():
    urls = filter(lambda x: x and not x.startswith('#'), map(lambda x: x.strip(), open('urls.txt', 'r').readlines()))
    log('DELAY: %s seconds' % DELAY)
    log(urls)

    while 1:
        results = map(try_get, urls)
        map(callback, results)

        warning = [dt.now().strftime(TIME_FORMAT)]
        for url, info in callback._status.items():
            if info['status'] == 1:
                warning.append('  {:30}: {}'.format(url, info['res']))
            else:
                if isinstance(info['res'], requests.Response):
                    log('  {:30}: {} {}'.format(url, info['res'].status_code, info['res'].reason))
                else:
                    log('  {:30}: {} {}'.format(url, info['res']))

        if len(warning) >= 2:
            log('Sending mail...')
            send_mail('\n'.join(warning))
        log('Sleeping...')
        time.sleep(DELAY)

if __name__ == '__main__':
    main()
