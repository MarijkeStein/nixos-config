#!/usr/bin/env bash

set -uxo pipefail

HOSTNAME=$(hostname)
cd "hosts/${HOSTNAME}"


if [[ -d "flakes" ]]
then
    nixos-rebuild switch --use-remote-sudo --flake .
else
    nixos-rebuild switch --use-remote-sudo
fi


# EOF
