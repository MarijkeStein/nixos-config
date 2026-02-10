#!/usr/bin/env bash

set -uxo pipefail

HOSTNAME=$(hostname)
cd "hosts/${HOSTNAME}" || exit 1


if [[ -d "flakes" ]]
then
    nix flake update
    nixos-rebuild switch --sudo --flake ./flakes
else
    nixos-rebuild switch --use-remote-sudo     # in future release changed to "--sudo"
fi


# EOF
