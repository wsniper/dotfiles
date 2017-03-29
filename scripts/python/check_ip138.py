#!/usr/bin/python
#coding:utf-8

"""
fork from: joe011/piython
modified by: weaming
"""

import urllib
import re
import sys


def is_IP(s):
    return len([i for i in s.split('.') if (0<= int(i)<= 255)]) == 4

def http_get(domain):
    url=urllib.urlopen('http://wap.ip138.com/ip.asp?ip=%s'%domain)
    text=url.read()
    return text

def from_ip(ip):
    fip = http_get(ip)
    rip=re.compile(r"<br/><b>查询结果：(.*)</b><br/>")
    result=rip.findall(fip)
    print "%s\t %s" % (ip,result[0])

def fix_text(txt):
    return txt.replace('\n', '').strip()

def from_domain(domain):
    text = http_get(domain)
    #r=re.compile(r'&gt;[\s\n]*(.*)[\s\n]*<br/><b>查询结果：(.*)</b><br/>', re.M)
    r=re.compile(r'&gt;(.*)<br/><b>查询结果：(.*)</b><br/>', re.S)
    result = map(lambda tp:map(fix_text, tp), r.findall(text))

    for i in result:
        print "%s\t %s\t %s\t" %(domain,i[0],i[1])

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print "请输入IP地址或者域名 (例如:192.168.1.1 / www.baidu.com)"
        sys.exit(1)

    INPUT=sys.argv[1]
    if not re.findall('(\d{1,3}\.){3}\d{1,3}',INPUT):
        if re.findall(r'(\w+\.)?(\w+)(\.\D+){1,2}',INPUT) :
            DOMAIN=INPUT
            from_domain(DOMAIN)
        else:
            print "输入的IP地址和域名格式不对！"
    else:
        if is_IP(INPUT)  :
            IPADDRESS=INPUT
            from_ip(IPADDRESS)
        else:
            print "IP 地址不合法，请重新输入！"

