#!/usr/bin/env bash

set -uxo pipefail

cd "flakes" || exit 1

nixos-rebuild switch --flake . --use-remote-sudo


# EOF
