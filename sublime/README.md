Usage
--
1. copy `Preferences.sublime-settings`'s content to `setting-user`
1. install `vintageousrc` plugin
1. Put `.vintageousrc` in `?\Sublime Text 3\Data\Packages\User` (windows7)
1. copy following to `user-keys` to bind key `jj` vim, which could exit insert mode.

	{
        "keys": ["j", "j"],
        "command": "_enter_normal_mode",
        "args": {
            "mode": "mode_insert"
        },
        "context": [{"key": "vi_insert_mode_aware"}]
    }

My plugins:

- Alignment
- CTags
- Git
- GitGutter
- JsFormat
- Markdown Preview
- Markdown Editing
- Side Bar
- Autoprefixer
- **ConvertToUTF8**
- CSScomb
- **Emmet**
- **Package Control**
- PlainTasks
- SublimeREPL
- Terminal
- ColorPicker

Links
--
- http://www.xuanfengge.com/practical-collection-of-sublime-plug-in.html