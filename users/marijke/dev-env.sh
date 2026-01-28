#!/usr/bin/env bash

set -euxo pipefail

pycharm &

signal-desktop &

fluffychat &

thunderbird &

keepassxc &

sleep 1

# Work log etc.
kate ~/misc/log/current.txt ~/Notes.txt &

firefox https://zeiterfassung.hfmdk-frankfurt.de &

nextcloud &


# EOF
