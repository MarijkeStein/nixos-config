#!/bin/sh

set -euxo pipefail

cd "users/marijke"
nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
nix-channel --update
home-manager switch --extra-experimental-features flakes


# EOF
