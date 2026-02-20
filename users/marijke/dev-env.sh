#!/usr/bin/env bash

set -euxo pipefail

pycharm ~/code/nixos-config ~/code/k3s-prod ~/projects/RZ/vertretungsmatrix &

signal-desktop &

fluffychat &

thunderbird &

keepassxc &

waveterm &

sleep 1

# Work log etc.
kate ~/misc/log/current.txt ~/Notes.txt &

firefox https://zeiterfassung.hfmdk-frankfurt.de https://owa.rz.hfmdk-frankfurt.de/owa/#path=/calendar/view/WorkWeek &

nextcloud &


# EOF
