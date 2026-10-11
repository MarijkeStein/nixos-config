#!/usr/bin/env bash

if [[ ! -e disko-config.nix ]]
then
    echo "Execute this script from within the host directory."
    exit 1
fi


nix run github:nix-community/nixos-anywhere -- --flake .#de-fsn01-rawfear root@de-fsn01-rawfear


# EOF
