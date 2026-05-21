#!/usr/bin/env bash
set -uo pipefail;

if [[ $(uname) == 'Darwin' ]] && [ "$(command -v brew)" ]; then
  brew install grep git curl coreutils;
  exit
fi;
