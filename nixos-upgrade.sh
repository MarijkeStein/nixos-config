#!/usr/bin/env bash

set -uxo pipefail

HOSTNAME=$(hostname)
VERSION_OLD=25.11
VERSION_NEW=26.05

cd "hosts/${HOSTNAME}" || exit 1

if [[ -d "flakes" ]]
then
    sed -i "s@nixos-${VERSION_OLD}@nixos-${VERSION_NEW}@" flake.nix
    nix flake update
    nixos-rebuild switch --flake . --sudo
else
    sudo nix-channel   --add "https://nixos.org/channels/nixos-${VERSION_NEW}" nixos
    sudo nix-channel   --update
    nixos-rebuild --sudo --upgrade switch
fi



# EOF
