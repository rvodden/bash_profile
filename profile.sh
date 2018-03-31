#!/bin/bash
export PATH=$PATH:~/bin:~/Applications/sonar-scanner/bin:/usr/local/pear/bin
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/vim/bin/":$PATH
export PATH="/opt/pmd/bin/":$PATH

## Sort out color man pages
[ -f ~/.less_termcap ] && . ~/.less_termcap

## Enable syntax highlighting with less
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '

## A few helpful aliases
alias ls='ls -FaG'
alias ll='ls -lFaG'
alias cdi="cd ~/Documents/Source/"
alias cdd="cd ~/Documents/Source/ipt/"
alias gitlog="git log --graph --full-history --all --color --pretty=format:\"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s\""
alias pmd="/opt/pmd/bin/run.sh pmd"
alias cpd="/opt/pmd/bin/run.sh cpd"

## Nail on bash completion
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
# for bundle
eval "$(complete_bundle_bash_command init)"

## Load liquid prompt
[ -f ~/.liquid_prompt/liquidprompt ] && source ~/.liquid_prompt/liquidprompt



## Load ssh ID if its not already loaded
if ! ssh-add -l >/dev/null; then
    ssh-add ~/.ssh/id_rsa
fi
