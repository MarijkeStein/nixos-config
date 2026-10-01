#!/usr/bin/env bash

set -euxo pipefail

cd "users/marijke"

if [[ -d "flakes" ]]
then
    exec home-manager switch -b backup --extra-experimental-features flakes
else
    exec home-manager switch -b backup
fi


# EOF
