# By https://github.com/weaming

# -------------------------------------------------------------------
# Add to ~/.bashrc if now work
# -------------------------------------------------------------------

# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

# -------------------------------------------------------------------
# Global varibales
# -------------------------------------------------------------------

PROXY=127.0.0.1:1080
wheezybackports='deb http://ftp.debian.org/debian wheezy-backports main'
alias f5="source ~/.bashrc"

# -------------------------------------------------------------------
# Shell promot color
# -------------------------------------------------------------------
# Note: Replace 0 with 1 for dark color
# \e[  – Indicates the beginning of color prompt
# x;ym – Indicates color code. Use the color code values mentioned below.
# \e[m – indicates the end of color prompt

E='\e[m'
Black='0;30'
Blue='0;34'
Green='0;32'
Cyan='0;36'
Red='0;31'
Purple='0;35'
Brown='0;33'

black="\e[${Black}m"
blue="\e[${Blue}m"
green="\e[${Green}m"
cyan="\e[${Cyan}m"
red="\e[${Red}m"
purple="\e[${Purple}m"
brown="\e[${Brown}m"

function git_ps1 {
  branch="`git branch 2>/dev/null | grep "^\*" | sed -e "s/^\*\ //"`"
  if [ "${branch}" != "" ];then
      if [ "${branch}" = "(no branch)" ];then
          branch="(`git rev-parse --short HEAD`...)"
      fi
      echo "($branch)"
  fi
}

if type __git_ps1 &>/dev/null; then
    GETBRANCH='`__git_ps1`'
else
    GETBRANCH=' `git_ps1`'
fi

# http://www.thegeekstuff.com/2008/09/bash-shell-ps1-10-examples-to-make-your-linux-prompt-like-angelina-jolie/
#export PS1="\t $? \u@\h:\w\n\$ "
export PS1="${green}\t$E ${purple}\$?$E ${red}\u$E@${cyan}\h$E:${brown}\w$E${GETBRANCH}\n\$ "

# -------------------------------------------------------------------
# Common aliases between bash and zsh
# -------------------------------------------------------------------
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

