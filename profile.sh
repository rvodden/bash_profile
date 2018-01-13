#!/bin/bash
export PATH=$PATH:~/bin:~/Applications/sonar-scanner/bin:/usr/local/pear/bin
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH="/usr/local/sbin:$PATH"

## Sort out color man pages
export LESS="-R"
[ -f ~/.less_termcap ] && . ~/.less_termcap

## A few helpful aliases
alias ls='ls -FaG'
alias ll='ls -lFaG'
alias cdi="cd /Users/voddenr/eclipse-workspace"
alias cdd="cd /Users/voddenr/ipt-workspace"
alias gitlog="git log --graph --full-history --all --color --pretty=format:\"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s\""

## Nail on bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

## Load ssh ID if its not already loaded
if ! ssh-add -l >/dev/null; then
    ssh-add ~/.ssh/id_rsa
fi
