#!/usr/bin/env bash

set -uxo pipefail

HOSTNAME=$(hostname)
cd "hosts/${HOSTNAME}"


if [[ -d "flakes" ]]
then
    nixos-rebuild switch --sudo --flake ./flakes
else
    nixos-rebuild switch --sudo
fi


# EOF
