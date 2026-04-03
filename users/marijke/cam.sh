#!/usr/bin/env bash

set -euxo pipefail

DEVICE="/dev/video4"

v4l2-ctl -d "${DEVICE}" --list-devices

v4l2-ctl -d "${DEVICE}" --list-ctrls

v4l2-ctl -d "${DEVICE}" --set-ctrl=focus_automatic_continuous=0
v4l2-ctl -d "${DEVICE}" --set-ctrl=focus_absolute=35


# EOF
