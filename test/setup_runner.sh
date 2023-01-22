#!/usr/bin/env sh

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