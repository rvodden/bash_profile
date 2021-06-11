#!/bin/bash

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/vim/bin/":$PATH
export PATH="/opt/pmd/bin/":$PATH
export PATH="~/go/bin":$PATH

# Sort out color man pages
[ -f ~/.less_termcap ] && . ~/.less_termcap

## Enable syntax highlighting with less
LESSPIPE=$(which src-hilite-lesspipe.sh)
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '

## A few helpful aliases
alias ls='ls -FaG'
alias ll='ls -lFaG'
alias cdi="cd ~/Documents/Source/"
alias cdd="cd ~/Documents/Source/babylon/"
alias gitlog="git log --graph --full-history --all --color --pretty=format:\"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s\""
alias pmd="/opt/pmd/bin/run.sh pmd"
alias cpd="/opt/pmd/bin/run.sh cpd"
alias vi="vim"

export EDITOR="/usr/local/bin/vim"
export VISUAL="/usr/local/bin/vim"

## Nail on bash completion (one of these two location will probably work :-) )
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh"  ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
## for bundle
eval "$(complete_bundle_bash_command init)"

# add okta autocompletion
[ -f ~/bash_profile/okta_complete.sh ] && source ~/bash_profile/okta_complete.sh
[ -f ~/bash_profile/okta_vault.sh ] && source ~/bash_profile/okta_vault.sh

# add aws autocompletion
[ -f /usr/local/bin/aws_completer  ] && complete -C '/usr/local/bin/aws_completer' aws

# add git completion
[ -f ~/bash_profile/git-completion.bash ] && source ~/bash_profile/git-completion.bash

# ## Load liquid prompt
# [ -f ~/liquidprompt/liquidprompt ] && source ~/liquidprompt/liquidprompt

# ## Load bashmarks

[ -f ~/.local/bin/bashmarks.sh ] && source ~/.local/bin/bashmarks.sh

## Load ssh ID if its not already loaded
if ! ssh-add -l >/dev/null; then
    ssh-add ~/.ssh/id_rsa
fi

## Loads NVM

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# # Load Pyenv

export homebrew_fury_user=ap4sxgml9yyukp3nmtym

# make history work better with multiple terminal windows
prompt_command="history -a; history -c; history -r; $prompt_command"
histcontrol=ignoreboth:erasedups

## run git in subdirectories
function gitd () {
    ARGUMENTS=( "${@}" )
    COMMAND="pushd > /dev/null {} && [[ -d .git ]] && echo {} && git ${ARGUMENTS[*]} ; popd > /dev/null && echo"
    export COMMAND
    find . -maxdepth 1 -mindepth 1 -type d -exec /usr/local/bin/bash -c "${COMMAND}" ";"
    unset COMMAND
}

## log into aws profile using okta and without changing shells
function aws-okta-login () {
    COMMANDS=( "add" "exec" "help" "login" "version" )
    eval "$('aws-okta' env ${1})"
}
