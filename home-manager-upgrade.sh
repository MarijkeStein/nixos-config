#!/bin/sh

set -euxo pipefail

VERSION_NEW=26.05

cd "users/marijke"

nix-channel --add "https://github.com/nix-community/home-manager/archive/release-${VERSION_NEW}.tar.gz" home-manager
nix-channel --update


# EOF
