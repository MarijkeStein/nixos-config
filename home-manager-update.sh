#!/usr/bin/env bash

set -euxo pipefail

cd "users/marijke"
nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
nix-channel --update

if [[ -d "flakes" ]]
then
    exec home-manager switch -b backup --extra-experimental-features flakes
else
    exec home-manager switch -b backup
fi


# EOF
