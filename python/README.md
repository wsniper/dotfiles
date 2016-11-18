# pip config file

[pip 9.0.1 documentation](https://pip.pypa.io/en/stable/user_guide/#config-file) or [pip/user_guide.rst](https://github.com/pypa/pip/blob/master/docs/user_guide.rst)

pip allows you to set all command line option defaults in a standard ini
style config file.

The names and locations of the configuration files vary slightly across
platforms. You may have **per-user, per-virtualenv or site-wide (shared amongst
all users)** configuration:

**Per-user**:

* On Unix the default configuration file is: `$HOME/.config/pip/pip.conf`
  which respects the `XDG_CONFIG_HOME` environment variable.
* On macOS the configuration file is
  `$HOME/Library/Application Support/pip/pip.conf`.
* On Windows the configuration file is `%APPDATA%\\pip\\pip.ini`.

There are also a legacy per-user configuration file which is also respected,
these are located at:

* On Unix and macOS the configuration file is: `$HOME/.pip/pip.conf`
* On Windows the configuration file is: `%HOME%\\pip\\pip.ini`

You can set a custom path location for this config file using the environment
variable `PIP_CONFIG_FILE`.

**Inside a virtualenv**:

* On Unix and macOS the file is `$VIRTUAL_ENV/pip.conf`
* On Windows the file is: `%VIRTUAL_ENV%\\pip.ini`

**Site-wide**:

* On Unix the file may be located in `/etc/pip.conf`. Alternatively
  it may be in a "pip" subdirectory of any of the paths set in the
  environment variable `XDG_CONFIG_DIRS` (if it exists), for example
  `/etc/xdg/pip/pip.conf`.
* On macOS the file is: `/Library/Application Support/pip/pip.conf`
* On Windows XP the file is:
  `C:\\Documents and Settings\\All Users\\Application Data\\pip\\pip.ini`
* On Windows 7 and later the file is hidden, but writeable at
  `C:\\ProgramData\\pip\\pip.ini`
* Site-wide configuration is not supported on Windows Vista

If multiple configuration files are found by pip then they are combined in
the following order:

1. Firstly the site-wide file is read, then
2. The per-user file is read, and finally
3. The virtualenv-specific file is read.

Each file read overrides any values read from previous files, so if the
global timeout is specified in both the site-wide file and the per-user file
then the latter value is the one that will be used.

