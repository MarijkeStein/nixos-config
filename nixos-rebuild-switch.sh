#!/usr/bin/env bash

set -uxo pipefail

HOSTNAME=$(hostname)
cd "hosts/${HOSTNAME}" || exit 1


if [[ -d "flakes" ]]
then
    nixos-rebuild switch --sudo --flake ./flakes
else
    nixos-rebuild switch --sudo
fi


# EOF
