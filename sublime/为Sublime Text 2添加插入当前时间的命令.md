想在代码注释时插入当前时间发现Sublime Text 2不支持，于是编写插件实现插入时间功能：

1.创建插件：

Tools → New Plugin:
```
import datetime
import sublime_plugin
class AddCurrentTimeCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        self.view.run_command("insert_snippet", 
            {
                "contents": "%s" % datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S") 
            }
        )
```
保存为`Sublime Text 2\Packages\User\addCurrentTime.py`

2.创建快捷键：

Preference → Key Bindings - User:
```
[
    {
        "command": "add_current_time",
        "keys": [
            "ctrl+shift+."
        ]
    }
]
```
3.此时使用快捷键`ctrl+shift+.`即可在当前光标处插入当前时间

参考：http://blog.csdn.net/billfeller/article/details/41460346
