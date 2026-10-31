#!/usr/bin/env bash

set -euxo pipefail

if [[ ! -e disko-config.nix ]]
then
    echo "Execute this script from within the host directory."
    exit 1
fi


nixos-rebuild switch --flake .#de-fsn01-rawfear --target-host marijke@de-fsn01-rawfear --sudo --ask-sudo-password


# EOF
