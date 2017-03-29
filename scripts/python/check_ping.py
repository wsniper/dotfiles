#!/usr/bin/python
#coding:utf-8
import multiprocessing
import re
import sys,os
import commands
import datetime
from pprint import pprint

def fix_text(text):
    return text.replace('\n', '').strip()

def pinger(ip, send=4):
    cmd='ping -c %s %s' % (send, ip.strip())
    ret = commands.getoutput(cmd)
    if 'unknow' in ret:
        return "%s\t%s" % (ip, 'DNS failed.')

    stat_re=re.compile(r", (.*) received, (.*) packet loss")
    stat = stat_re.findall(ret)[0]
    packet_receive = stat[0]
    packet_loss = stat[1]

    rtt_re=re.compile(r"rtt min/avg/max/mdev = (.*) ")
    rtts=rtt_re.findall(ret)

    rtt=rtts[0].split('/')
    rtt_min=rtt[0]
    rtt_avg=rtt[1]
    rtt_max=rtt[2]
    return "%s\t%s\t%s\t%s\t%s\t%s\t%s"%(ip, send, packet_receive, packet_loss,rtt_min,rtt_max,rtt_avg)

def ping_print(ip):
    print pinger(ip)


if __name__ == "__main__":
    if not os.path.exists("hosts.txt"):
        print "\033[31mhosts.txt文件不存在，请重试\033[0m"
        sys.exit(1)

    now=datetime.datetime.now()
    pool=multiprocessing.Pool(processes=4)
    result=[]

    print "======== %s ======"%now
    print "IP/DOMAIN\tSEND\tRCV\tLOSS\tMIN\tMAX\tAVG"

    with open('hosts.txt','r') as file:
        for i in file.readlines():
            if len(i)==1 or i.strip().startswith("#"):
                continue
            result.append(pool.apply_async(ping_print,(i.strip(),)))
            #ping_print(i.strip())

    pool.close()
    pool.join()
