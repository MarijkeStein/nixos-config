#!/usr/bin/env bash

set -uxo pipefail

cd "flakes" || exit 1
nix flake update

nixos-rebuild switch --flake . --use-remote-sudo     # in future release changed to "--sudo"


# EOF
