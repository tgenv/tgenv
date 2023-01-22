#!/usr/bin/env bash
set -uo pipefail;

if [[ $(uname) == 'Darwin' ]] && [ $(which brew) ]; then
  brew install grep;
  exit
fi;

. /etc/os-release
if [[ "${ID}" == "alpine" ]]; then
    apk add bash git
fi

if [[ "${ID}" == "ubuntu" ]]; then
    apt update -y
    apt install -y git
fi

if [[ "${ID}" == "fedora" ]]; then
    yum update -y
    yum install git -y
fi