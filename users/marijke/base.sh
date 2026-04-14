#!/usr/bin/env bash

set -euxo pipefail

keepassxc &

#gnome-terminal --full-screen -- zellij &

sleep 1

# Work log etc.
kate ~/misc/log/current.txt ~/Notes.txt &

firefox https://zeiterfassung.hfmdk-frankfurt.de https://owa.rz.hfmdk-frankfurt.de/owa/#path=/calendar/view/WorkWeek &

# EOF
