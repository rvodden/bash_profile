#!/usr/bin/env bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export SHIPCAT_MANIFEST_DIR=~/Documents/Source/babylon/manifests

vault-okta-login() {
  unset VAULT_TOKEN
  unset VAULT_NAME
  unset VAULT_ADDR

  echo "${SHIPCAT_MANIFEST_DIR}/shipcat.conf"

  if [ -z "${1}" ]; then
    VAULT_NAME=$(yq -y ".regions[].vault.folder" ${SHIPCAT_MANIFEST_DIR}/shipcat.conf  | awk '{print $2}' | fzf +m)
    else
    VAULT_NAME=${1}
  fi
  VAULT_ADDR="$(yq -y ".regions | map(select(.name == \"$VAULT_NAME\") .vault)" < ${SHIPCAT_MANIFEST_DIR}/shipcat.conf | yq '.[0].url' -r)"

  echo 'Name: '$VAULT_NAME
  echo 'Server: '$VAULT_ADDR
  export VAULT_ADDR

  vault login -method=okta username=richard.vodden

}
