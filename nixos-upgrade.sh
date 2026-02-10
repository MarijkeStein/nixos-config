#!/usr/bin/env bash

set -uxo pipefail

HOSTNAME=$(hostname)
cd "hosts/${HOSTNAME}" || exit 1


if [[ -d "flakes" ]]
then
    sed -i 's@nixos-25.05@nixos-25.11@' flake.nix
    nix flake update
    nixos-rebuild switch --flake . --use-remote-sudo     # in future release changed to "--sudo"
else
    sudo nix-channel   --add https://nixos.org/channels/nixos-25.11 nixos
    sudo nix-channel   --update
    nixos-rebuild --use-remote-sudo --upgrade switch     # in future release changed to "--sudo"
fi



# EOF
