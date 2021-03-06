#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
命令行版本的有道词典，调用有道翻译的 API 实现

用法一：
    % python youdao.py search
    原文： search
    发音： sɜːtʃ
    解释：

    n. 搜寻；探究，查究
    vt. 搜索；搜寻；调查；搜查；探求
    vi. 搜寻；调查；探求
    n. (Search)人名；(英)瑟奇

用法二（推荐）：
    % mv youdao.py ~/bin/youdao  # 添加到用户的 PATH
    % chmod +x ~/bin/youdao      # 赋予可执行权限
    % youdao search              # 在任意路径下都可以方便使用了
    原文： search
    发音： sɜːtʃ
    解释：

    n. 搜寻；探究，查究
    vt. 搜索；搜寻；调查；搜查；探求
    vi. 搜寻；调查；探求
    n. (Search)人名；(英)瑟奇

"""

import requests


class YoudaoDict(object):
    def __init__(self, keyfrom, key, version="1.1"):
        self.keyfrom = keyfrom
        self.key = key
        self.version = version
        self.base_url = "http://fanyi.youdao.com/openapi.do"

    def _fetch_json(self, q):
        params = {
            "keyfrom": self.keyfrom,
            "key": self.key,
            "type": "data",
            "doctype": "json",
            "version": self.version,
            "only": "dict",
            "q": q
        }
        resp = requests.get(self.base_url, params=params, timeout=5)
        return resp.json()

    def _has_error(self, error_code):
        return error_code != 0

    def _error_info(self, error_code):
        return {
            20: u"要翻译的文本过长",
            30: u"无法进行有效的翻译",
            40: u"不支持的语言类型",
            50: u"无效的key",
            60: u"无词典结果，仅在获取词典结果生效"
        }.get(error_code, u"未知错误：%s" % error_code)

    def _output(self, _json):
        rv = []
        error_code = _json.get("errorCode")
        query = _json.get("query")

        if self._has_error(error_code):
            return u'{}: {}'.format(query, self._error_info(error_code))

        rv.append(u"原文：" + query)
        basic = _json.get("basic", None)
        if basic is None:
            rv.append(u"解释：查无释义")
        else:
            rv.append(u"发音：" + basic.get("phonetic", ""))
            rv.append(u"解释：\n")
            rv.append("\n".join(basic.get("explains", [])))
        return '\n'.join(rv)

    def lookup(self, q):
        resp = self._fetch_json(q)
        return self._output(resp)


if __name__ == '__main__':
    import sys

    # 去 http://fanyi.youdao.com/openapi?path=data-mode 申请一个 key
    # 会得到 keyfrom 和 key 两个值，然后替换到这里
    # 现在最新版是 1.1
    key = 1223233064
    keyfrom = 'weaming'
    youdao = YoudaoDict(keyfrom, key, "1.1")

    if len(sys.argv) < 2:
        print(u"Usage: %s [query]" % __file__)
        sys.exit(1)

    queries = sys.argv[1:]
    output = []
    for q in queries:
        output.append(youdao.lookup(q))
    print('\n\n=========================\n'.join(output))
