#!/usr/bin/env sh

if [ "$(uname)" = 'Darwin' ]; then
  brew install grep git curl
fi;

. /etc/os-release
if [ "${ID}" = "alpine" ]; then
    apk add bash git curl
fi

if [ "${ID}" = "ubuntu" ]; then
    apt update -y
    apt install -y git curl
fi

if [ "${ID}" = "fedora" ]; then
    yum update -y
    yum install -y git curl
fi