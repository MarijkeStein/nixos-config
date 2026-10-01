#!/bin/sh

set -euxo pipefail

cd "users/marijke"

if [[ -d "flakes" ]]
then
    exec home-manager switch --extra-experimental-features flakes
else
    exec home-manager switch
fi


# EOF
