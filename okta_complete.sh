#!/usr/bin/env bash

__debug()
{
    if [[ -n ${BASH_COMP_DEBUG_FILE} ]]; then
        echo "$*" >> "${BASH_COMP_DEBUG_FILE}"
    fi
}

_aws-okta () {

  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  local cmd
  cmd=${COMP_WORDS[1]}
  local prev
  prev=${COMP_WORDS[COMP_CWORD-1]}
  local profiles
  profiles=$(awk '/profile/ {print $2}' ~/.aws/config |tr -d \])
  local params
  params="--backend --debug --help --"
  local commands
  commands="add exec help login version"

  COMPREPLY=()

  case "$cmd" in
    exec|env)
        COMPREPLY=( $(compgen -W "${profiles}" -- "${cur}") )
        ;;
    -*)
        COMPREPLY=( $(compgen -W "${params}" -- "${cur}") )
        ;;
     *)
        COMPREPLY=( $(compgen -W "${profiles}" -- "${cur}") )
        ;;
  esac
  return 0
}

complete -F _aws-okta aws-okta

_aws-okta-login () {

  local profiles
  profiles=$(awk '/profile/ {print $2}' ~/.aws/config |tr -d \])
  COMPREPLY=()

  case "$cmd" in
     *)
        COMPREPLY=( $(compgen -W "${profiles}" -- "${cur}") )
        ;;
  esac
  return 0
}

complete -F _aws-okta-login aws-okta-login
