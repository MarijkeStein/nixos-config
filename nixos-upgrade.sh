#!/usr/bin/env bash

set -uxo pipefail

HOSTNAME=$(hostname)
cd "hosts/${HOSTNAME}" || exit 1


if [[ -d "flakes" ]]
then
    sed -i 's@nixos-25.05@nixos-25.11@' flake.nix
    nix flake update
    nixos-rebuild switch --flake . --sudo
else
    sudo nix-channel   --add https://nixos.org/channels/nixos-25.11 nixos
    sudo nix-channel   --update
    nixos-rebuild --sudo --upgrade switch
fi



# EOF
