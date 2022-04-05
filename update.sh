#!/bin/bash

ME="$(readlink -f "$0")"
OMZ_DIR="$(dirname "${ME}")"

LOG="${HOME}/.cache/omz-upstream-update.log"

# shellcheck disable=SC2164
cd "${OMZ_DIR}" 

# shellcheck disable=SC2181
if [ ! -d "${OMZ_DIR}/.git/refs/remotes/upstream" ]; then
  
  echo " >> Setting up upstream git"
  git remote add upstream https://github.com/ohmyzsh/ohmyzsh.git &>>"${LOG}"
  git fetch upstream &>>"${LOG}"
  if [ $? -ne 0 ]; then
    echo " !! Setting up upstream git failed, check '${LOG}' for details!"
    exit 1
  fi
fi

echo " >> Updating from upstream..."
git pull --rebase upstream master &>>"${LOG}"
echo " >> Pushing changes from upstream..."
git push origin master &>>"${LOG}"
